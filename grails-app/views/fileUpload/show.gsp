<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>文件详情</title>
</head>
<body>
    <div class="container">
        <h1>文件详情</h1>
        
        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>
        
        <g:if test="${flash.error}">
            <div class="alert alert-danger">${flash.error}</div>
        </g:if>
        
        <div class="file-details">
            <div class="row">
                <div class="col-md-3 font-weight-bold">文件名:</div>
                <div class="col-md-9">${fileUpload.originalFilename}</div>
            </div>
            
            <div class="row">
                <div class="col-md-3 font-weight-bold">大小:</div>
                <div class="col-md-9"><fileUpload:formatFileSize size="${fileUpload.fileSize}"/></div>
            </div>
            
            <div class="row">
                <div class="col-md-3 font-weight-bold">类型:</div>
                <div class="col-md-9">${fileUpload.contentType}</div>
            </div>
            
            <div class="row">
                <div class="col-md-3 font-weight-bold">上传日期:</div>
                <div class="col-md-9"><g:formatDate date="${fileUpload.dateCreated}" format="yyyy-MM-dd HH:mm:ss"/></div>
            </div>
            
            <div class="row">
                <div class="col-md-3 font-weight-bold">上传者:</div>
                <div class="col-md-9">${fileUpload.uploadedBy.username}</div>
            </div>
            
            <g:if test="${fileUpload.description}">
                <div class="row">
                    <div class="col-md-3 font-weight-bold">描述:</div>
                    <div class="col-md-9">${fileUpload.description}</div>
                </div>
            </g:if>
        </div>
        
        <div class="buttons mt-4">
            <g:link action="download" id="${fileUpload.id}" class="btn btn-success">下载</g:link>
            <g:link action="myFiles" class="btn btn-secondary">返回列表</g:link>
            <g:link action="delete" id="${fileUpload.id}" class="btn btn-danger" 
                   onclick="return confirm('确定要删除此文件吗?');">删除</g:link>
        </div>
    </div>
</body>
</html>