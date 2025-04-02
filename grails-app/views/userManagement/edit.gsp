<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>编辑用户 - ${user.username}</title>
</head>
<body>
    <div class="row">
        <div class="col-md-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><g:link action="index">用户管理</g:link></li>
                    <li class="breadcrumb-item"><g:link action="show" id="${user.id}">查看用户</g:link></li>
                    <li class="breadcrumb-item active" aria-current="page">编辑用户</li>
                </ol>
            </nav>
            
            <h1>编辑用户: ${user.username}</h1>
            
            <g:hasErrors bean="${user}">
                <div class="alert alert-danger">
                    <ul>
                        <g:eachError bean="${user}" var="error">
                            <li><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </div>
            </g:hasErrors>
            
            <div class="card">
                <div class="card-body">
                    <g:form action="update" id="${user.id}" method="POST">
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">用户名:</label>
                            <div class="col-sm-9">
                                <g:textField name="username" value="${user?.username}" class="form-control" required="true" />
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">新密码:</label>
                            <div class="col-sm-9">
                                <g:passwordField name="newPassword" class="form-control" />
                                <small class="form-text text-muted">留空表示不修改密码</small>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">账号启用:</label>
                            <div class="col-sm-9">
                                <div class="form-check mt-2">
                                    <g:checkBox name="enabled" value="${user?.enabled}" class="form-check-input" />
                                    <label class="form-check-label">启用此用户账号</label>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">账号状态设置:</label>
                            <div class="col-sm-9">
                                <div class="form-check mb-2">
                                    <g:checkBox name="accountExpired" value="${user?.accountExpired}" class="form-check-input" />
                                    <label class="form-check-label">账号已过期</label>
                                </div>
                                <div class="form-check mb-2">
                                    <g:checkBox name="accountLocked" value="${user?.accountLocked}" class="form-check-input" />
                                    <label class="form-check-label">账号已锁定</label>
                                </div>
                                <div class="form-check">
                                    <g:checkBox name="passwordExpired" value="${user?.passwordExpired}" class="form-check-input" />
                                    <label class="form-check-label">密码已过期</label>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">角色分配:</label>
                            <div class="col-sm-9">
                                <g:each in="${roles}" var="role">
                                    <div class="form-check">
                                        <g:checkBox name="roleIds" value="${role.id}" 
                                                   checked="${userRoles?.contains(role)}" class="form-check-input" />
                                        <label class="form-check-label">
                                            ${role.authority} (${role.authority.replace('ROLE_', '')})
                                        </label>
                                    </div>
                                </g:each>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <div class="col-sm-9 offset-sm-3">
                                <g:submitButton name="update" value="更新用户" class="btn btn-primary" />
                                <g:link action="show" id="${user.id}" class="btn btn-secondary">取消</g:link>
                            </div>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 