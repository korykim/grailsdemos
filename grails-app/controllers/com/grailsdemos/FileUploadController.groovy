package com.grailsdemos

import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import org.springframework.security.core.context.SecurityContextHolder

@Secured(['ROLE_ADMIN','ROLE_USER'])
class FileUploadController {
    
    FileUploadService fileUploadService
    def springSecurityService
    
    static allowedMethods = [
        upload: "POST", 
        download: "GET", 
        list: "GET", 
        delete: "DELETE",
        multiUpload: "POST"
    ]
    
    // 文件上传表单页面
    def index() {
        respond new FileUpload(params)
    }
    
    // 处理文件上传
    def upload() {
        def file = request.getFile('file')
        
        if (file.empty) {
            flash.message = "请选择要上传的文件"
            redirect(action: "index")
            return
        }
        
        // 获取当前登录用户
        def currentUser = springSecurityService.currentUser as User
        
        try {
            def fileUpload = fileUploadService.saveFile(
                file, 
                currentUser, 
                params.description
            )
            
            flash.message = "文件 '${fileUpload.originalFilename}' 上传成功"
            redirect(action: "show", id: fileUpload.id)
        } catch (Exception e) {
            flash.error = "文件上传失败: ${e.message}"
            redirect(action: "index")
        }
    }
    
    // 显示文件详情
    def show(Long id) {
        respond fileUploadService.getFile(id)
    }
    
    // 列出当前用户的所有文件
    def myFiles() {
        def currentUser = springSecurityService.currentUser as User
        params.max = Math.min(params.max ?: 10, 100)
        def fileUploadList = fileUploadService.listUserFiles(currentUser, params)
        def fileUploadCount = FileUpload.countByUploadedBy(currentUser)
        
        respond fileUploadList, model: [fileUploadCount: fileUploadCount]
    }
    
    // 列出所有文件(管理员权限)
    @Secured('ROLE_ADMIN')
    def list() {
        params.max = Math.min(params.max ?: 10, 100)
        def fileUploadList = fileUploadService.listAllFiles(params)
        def fileUploadCount = FileUpload.count()
        
        respond fileUploadList, model: [fileUploadCount: fileUploadCount]
    }
    
    // 下载文件
    def download(Long id) {
        FileUpload fileUpload = fileUploadService.getFile(id)
        
        if (!fileUpload) {
            notFound()
            return
        }
        
        File file = new File(fileUpload.filePath)
        
        if (!file.exists()) {
            flash.error = "文件 '${fileUpload.originalFilename}' 不存在或已被删除"
            redirect(action: "myFiles")
            return
        }
        
        response.setContentType(fileUpload.contentType)
        response.setHeader("Content-disposition", "attachment; filename=\"${fileUpload.originalFilename}\"")
        response.outputStream << file.bytes
        response.outputStream.flush()
    }
    
    // 删除文件
    def delete(Long id) {
        try {
            fileUploadService.deleteFile(id)
            flash.message = "文件已成功删除"
        } catch (Exception e) {
            flash.error = "文件删除失败: ${e.message}"
        }
        
        redirect(action: "myFiles")
    }
    
    // 多文件上传
    def multiUpload() {
        def files = request.multiFileMap.getFiles('files')
        def currentUser = springSecurityService.currentUser as User
        def description = params.description
        
        if (!files || files.isEmpty()) {
            flash.error = "请选择要上传的文件"
            redirect(action: "index")
            return
        }
        
        def successCount = 0
        def errorMessages = []
        
        files.each { file ->
            if (!file.empty) {
                try {
                    fileUploadService.saveFile(file, currentUser, description)
                    successCount++
                } catch (Exception e) {
                    errorMessages << "文件 '${file.originalFilename}' 上传失败: ${e.message}"
                }
            }
        }
        
        if (successCount > 0) {
            flash.message = "${successCount} 个文件上传成功"
        }
        
        if (errorMessages) {
            flash.error = errorMessages.join('<br>')
        }
        
        redirect(action: "myFiles")
    }
    
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.error = message(code: 'default.not.found.message', args: [message(code: 'fileUpload.label', default: 'File'), params.id])
                redirect action: "myFiles", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}