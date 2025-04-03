<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>上传文件</title>
</head>
<body>
    <div class="container">
        <h1>上传文件</h1>
        
        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>
        
        <g:if test="${flash.error}">
            <div class="alert alert-danger">${flash.error}</div>
        </g:if>
        
        <ul class="nav nav-tabs" id="uploadTabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="single-tab" data-toggle="tab" href="#single" role="tab">单文件上传</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="multi-tab" data-toggle="tab" href="#multi" role="tab">多文件上传</a>
            </li>
        </ul>
        
        <div class="tab-content" id="uploadTabsContent">
            <div class="tab-pane fade show active p-3" id="single" role="tabpanel">
                <g:form action="upload" method="post" enctype="multipart/form-data" class="form">
                    <div class="form-group">
                        <label for="file">选择文件:</label>
                        <input type="file" name="file" class="form-control" required/>
                    </div>
                    
                    <div class="form-group">
                        <label for="description">文件描述:</label>
                        <textarea name="description" class="form-control" rows="3"></textarea>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">上传</button>
                        <g:link action="myFiles" class="btn btn-secondary">我的文件</g:link>
                    </div>
                </g:form>
            </div>
            
            <div class="tab-pane fade p-3" id="multi" role="tabpanel">
                <g:form action="multiUpload" method="post" enctype="multipart/form-data" class="form">
                    <div class="form-group">
                        <label for="files">选择多个文件:</label>
                        <input type="file" name="files" multiple class="form-control" required/>
                        <small class="form-text text-muted">按住 Ctrl 键可选择多个文件</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="description">文件描述 (适用于所有文件):</label>
                        <textarea name="description" class="form-control" rows="3"></textarea>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">批量上传</button>
                        <g:link action="myFiles" class="btn btn-secondary">我的文件</g:link>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</body>
</html>