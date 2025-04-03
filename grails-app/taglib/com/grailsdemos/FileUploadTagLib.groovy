package com.grailsdemos

class FileUploadTagLib {
    static namespace = "fileUpload"
    
    def formatFileSize = { attrs ->
        def size = attrs.size as Long
        def units = ['B', 'KB', 'MB', 'GB', 'TB']
        int unitIndex = 0
        double fileSize = size
        
        while (fileSize > 1024 && unitIndex < units.size() - 1) {
            fileSize = fileSize / 1024
            unitIndex++
        }
        
        out << String.format("%.2f %s", fileSize, units[unitIndex])
    }
}