package com.grailsdemos

import org.springframework.web.multipart.MultipartFile

class FileUpload {
    // 文件原始名称
    String originalFilename
    // 存储的文件名（通常使用UUID等确保唯一性）
    String storedFilename
    // 文件路径
    String filePath
    // 文件大小（字节）
    Long fileSize
    // 文件类型（MIME类型）
    String contentType
    // 上传日期
    Date dateCreated
    // 上传者（关联到User）
    User uploadedBy
    // 文件描述
    String description
    
    static belongsTo = [uploadedBy: User]
    
    static constraints = {
        originalFilename nullable: false, blank: false
        storedFilename nullable: false, blank: false
        filePath nullable: false, blank: false
        fileSize nullable: false, min: 0L
        contentType nullable: false, blank: false
        description nullable: true, blank: true, maxSize: 1000
    }
    
    static mapping = {
        description type: 'text'
    }
    
    // 用于传输的文件属性，不存储在数据库中
    static transients = ['file']
    MultipartFile file
}