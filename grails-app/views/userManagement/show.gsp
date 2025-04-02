<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>查看用户 - ${user.username}</title>
</head>
<body>
    <div class="row">
        <div class="col-md-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><g:link action="index">用户管理</g:link></li>
                    <li class="breadcrumb-item active" aria-current="page">查看用户</li>
                </ol>
            </nav>
            
            <h1>用户详情: ${user.username}</h1>
            
            <div class="button-group mb-3">
                <g:link action="index" class="btn btn-secondary">返回列表</g:link>
                <g:link action="edit" id="${user.id}" class="btn btn-primary">编辑</g:link>
                <g:link action="delete" id="${user.id}" class="btn btn-danger" 
                        onclick="return confirm('确定要删除此用户吗?');">删除</g:link>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <h5>基本信息</h5>
                </div>
                <div class="card-body">
                    <dl class="row">
                        <dt class="col-sm-3">ID:</dt>
                        <dd class="col-sm-9">${user.id}</dd>
                        
                        <dt class="col-sm-3">用户名:</dt>
                        <dd class="col-sm-9">${user.username}</dd>
                        
                        <dt class="col-sm-3">账号状态:</dt>
                        <dd class="col-sm-9">
                            <g:if test="${user.enabled}">
                                <span class="badge badge-success">启用</span>
                            </g:if>
                            <g:else>
                                <span class="badge badge-danger">禁用</span>
                            </g:else>
                        </dd>
                        
                        <dt class="col-sm-3">账号锁定:</dt>
                        <dd class="col-sm-9">
                            <g:if test="${user.accountLocked}">
                                <span class="badge badge-warning">已锁定</span>
                            </g:if>
                            <g:else>
                                <span class="badge badge-success">未锁定</span>
                            </g:else>
                        </dd>
                        
                        <dt class="col-sm-3">账号过期:</dt>
                        <dd class="col-sm-9">
                            <g:if test="${user.accountExpired}">
                                <span class="badge badge-warning">已过期</span>
                            </g:if>
                            <g:else>
                                <span class="badge badge-success">未过期</span>
                            </g:else>
                        </dd>
                        
                        <dt class="col-sm-3">密码过期:</dt>
                        <dd class="col-sm-9">
                            <g:if test="${user.passwordExpired}">
                                <span class="badge badge-warning">已过期</span>
                            </g:if>
                            <g:else>
                                <span class="badge badge-success">未过期</span>
                            </g:else>
                        </dd>
                    </dl>
                </div>
            </div>
            
            <div class="card mt-4">
                <div class="card-header">
                    <h5>角色信息</h5>
                </div>
                <div class="card-body">
                    <g:if test="${userRoles}">
                        <ul class="list-group">
                            <g:each in="${userRoles}" var="role">
                                <li class="list-group-item">
                                    <span class="badge badge-info">${role.authority}</span>
                                    <span class="ml-2">${role.authority.replace('ROLE_', '')}</span>
                                </li>
                            </g:each>
                        </ul>
                    </g:if>
                    <g:else>
                        <p class="text-muted">该用户没有分配角色</p>
                    </g:else>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 