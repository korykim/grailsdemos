package com.grailsdemos

import grails.gorm.transactions.Transactional
import org.springframework.web.multipart.MultipartFile
import java.nio.file.Files
import java.nio.file.Paths
import java.nio.file.StandardCopyOption
import javax.imageio.ImageIO
import java.awt.image.BufferedImage
import java.awt.Graphics2D
import java.awt.RenderingHints
import java.io.IOException
import java.io.InputStream

@Transactional
class FileUploadService {
    
    // 配置中定义的文件上传路径
    def grailsApplication
    
    // 获取文件上传路径
    String getUploadPath() {
        def path = grailsApplication.config.getProperty('file.upload.directory')
        if (!path) {
            // 默认路径，可在配置中自定义
            path = System.getProperty("java.io.tmpdir")
        }
        return path
    }
    
    // 验证文件类型是否允许
    boolean isFileTypeAllowed(String contentType) {
        def allowedTypes = grailsApplication.config.getProperty('file.upload.allowed-types', List, [])
        return allowedTypes.isEmpty() || allowedTypes.contains(contentType)
    }
    
    // 保存上传文件
    FileUpload saveFile(MultipartFile file, User user, String description) {
        if (file.empty) {
            throw new IllegalArgumentException("文件不能为空")
        }
        
        // 验证文件大小
        long maxSize = grailsApplication.config.getProperty('file.upload.max-size', Long, 10485760L) // 默认10MB
        if (file.size > maxSize) {
            throw new IllegalArgumentException("文件大小超过限制 (最大 ${maxSize/1024/1024} MB)")
        }
        
        // 验证文件类型
        if (!isFileTypeAllowed(file.contentType)) {
            throw new IllegalArgumentException("不支持的文件类型: ${file.contentType}")
        }
        
        // 生成唯一文件名（使用UUID防止文件名冲突）
        String originalFilename = file.originalFilename
        String extension = ""
        int dotIndex = originalFilename.lastIndexOf('.')
        if (dotIndex > 0) {
            extension = originalFilename.substring(dotIndex)
        }
        String storedFilename = UUID.randomUUID().toString() + extension
        
        // 确保上传目录存在
        File uploadDir = new File(getUploadPath())
        if (!uploadDir.exists()) {
            uploadDir.mkdirs()
        }
        
        // 构建文件路径
        String filePath = getUploadPath() + File.separator + storedFilename
        
        // 使用Java NIO Files API保存文件，而不是transferTo方法
        try {
            // 创建InputStream从MultipartFile获取内容
            InputStream inputStream = file.getInputStream()
            // 使用Files.copy安全地复制文件
            Files.copy(inputStream, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING)
            inputStream.close()
        } catch (IOException e) {
            throw new RuntimeException("保存文件失败: " + e.getMessage(), e)
        }
        
        // 创建并保存文件记录
        FileUpload fileUpload = new FileUpload(
            originalFilename: originalFilename,
            storedFilename: storedFilename,
            filePath: filePath,
            fileSize: file.size,
            contentType: file.contentType,
            uploadedBy: user,
            description: description
        )
        
        fileUpload.save(flush: true, failOnError: true)
        return fileUpload
    }
    
    // 获取文件
    FileUpload getFile(Long id) {
        return FileUpload.get(id)
    }
    
    // 列出用户的所有文件
    List<FileUpload> listUserFiles(User user, Map params) {
        return FileUpload.findAllByUploadedBy(user, params)
    }
    
    // 列出所有文件
    List<FileUpload> listAllFiles(Map params) {
        return FileUpload.list(params)
    }
    
    // 删除文件
    void deleteFile(Long id) {
        FileUpload fileUpload = FileUpload.get(id)
        if (fileUpload) {
            // 删除物理文件
            File file = new File(fileUpload.filePath)
            if (file.exists()) {
                file.delete()
            }
            // 删除数据库记录
            fileUpload.delete(flush: true)
        }
    }
    
    void generateThumbnail(FileUpload fileUpload) {
        if (!fileUpload.contentType.startsWith('image/')) {
            return // 只处理图片
        }
        
        try {
            File originalFile = new File(fileUpload.filePath)
            BufferedImage originalImage = ImageIO.read(originalFile)
            
            // 计算缩略图尺寸，保持宽高比
            int maxWidth = 200
            int maxHeight = 200
            int width = originalImage.width
            int height = originalImage.height
            
            if (width > height) {
                height = (int) (height * (maxWidth / (double) width))
                width = maxWidth
            } else {
                width = (int) (width * (maxHeight / (double) height))
                height = maxHeight
            }
            
            // 创建缩略图
            BufferedImage thumbnail = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB)
            Graphics2D g = thumbnail.createGraphics()
            g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR)
            g.drawImage(originalImage, 0, 0, width, height, null)
            g.dispose()
            
            // 保存缩略图
            String thumbFileName = "thumb_${fileUpload.storedFilename}"
            String thumbFilePath = getUploadPath() + File.separator + thumbFileName
            File thumbFile = new File(thumbFilePath)
            
            String format = fileUpload.originalFilename.substring(fileUpload.originalFilename.lastIndexOf('.') + 1).toLowerCase()
            ImageIO.write(thumbnail, format, thumbFile)
            
            // 更新文件记录
            fileUpload.thumbnailPath = thumbFilePath
            fileUpload.save(flush: true)
        } catch (Exception e) {
            log.error("生成缩略图失败: ${e.message}", e)
        }
    }
}