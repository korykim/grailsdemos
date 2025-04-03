<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>文件列表</title>
</head>
<body>
    <div class="container">
        <h1>我的文件</h1>
        
        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>
        
        <g:if test="${flash.error}">
            <div class="alert alert-danger">${flash.error}</div>
        </g:if>
        
        <div class="buttons">
            <g:link action="index" class="btn btn-primary">上传新文件</g:link>
        </div>
        
        <table class="table">
            <thead>
                <tr>
                    <th>文件名</th>
                    <th>大小</th>
                    <th>类型</th>
                    <th>上传日期</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${fileUploadList}" var="file">
                    <tr>
                        <td>${file.originalFilename}</td>
                        <td><fileUpload:formatFileSize size="${file.fileSize}"/></td>
                        <td>${file.contentType}</td>
                        <td><g:formatDate date="${file.dateCreated}" format="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>
                            <g:link action="download" id="${file.id}" class="btn btn-sm btn-success">下载</g:link>
                            <g:link action="show" id="${file.id}" class="btn btn-sm btn-info">详情</g:link>
                            <g:link action="delete" id="${file.id}" class="btn btn-sm btn-danger" 
                                   onclick="return confirm('确定要删除此文件吗?');">删除</g:link>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>
        
        <div class="pagination">
            <g:paginate total="${fileUploadCount ?: 0}" />
        </div>
    </div>
</body>
</html>