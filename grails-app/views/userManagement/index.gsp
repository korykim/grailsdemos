<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>用户管理</title>
    <asset:stylesheet src="font-awesome.min.css"/>
    <style>
        .user-table {
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
            background-color: white;
        }
        .user-table thead {
            background-color: #343a40;
            color: white;
        }
        .user-table th {
            font-weight: 600;
            padding: 12px 15px;
            text-align: left;
        }
        .user-table td {
            padding: 12px 15px;
            color: #333;
            vertical-align: middle;
        }
        .user-table tbody tr:nth-of-type(even) {
            background-color: #f8f9fa;
        }
        .user-table tbody tr:hover {
            background-color: #f1f1f1;
        }
        .badge-role {
            margin-right: 4px;
            margin-bottom: 4px;
            padding: 5px 8px;
            display: inline-block;
            background-color: #6c757d;
            color: white;
            font-weight: 500;
        }
        .badge {
            padding: 5px 8px;
            margin-right: 5px;
            border-radius: 4px;
            font-weight: normal;
            display: inline-flex;
            align-items: center;
        }
        .badge i {
            margin-right: 4px;
        }
        .badge-success {
            background-color: #28a745;
            color: white;
        }
        .badge-danger {
            background-color: #dc3545;
            color: white;
        }
        .badge-warning {
            background-color: #ffc107;
            color: #212529;
        }
        .badge-info {
            background-color: #17a2b8;
            color: white;
        }
        .action-buttons .btn {
            padding: 6px 12px;
            margin-right: 3px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        .action-buttons .btn i {
            margin-right: 4px;
        }
        .page-title {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e9ecef;
            color: #343a40;
        }
        .user-table-container {
            margin-bottom: 20px;
            border-radius: 8px;
            overflow: hidden;
        }
        .empty-message {
            padding: 30px;
            text-align: center;
            color: #6c757d;
        }
        .empty-message i {
            font-size: 24px;
            margin-bottom: 10px;
            display: block;
        }
        .pagination-container {
            margin-top: 20px;
        }
        .username-cell {
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="row">
        <div class="col-md-12">
            <h1 class="page-title">用户管理</h1>
            
            <div class="d-flex justify-content-between align-items-center mb-3">
                <g:link action="create" class="btn btn-primary">
                    <i class="fa fa-plus-circle"></i> 创建新用户
                </g:link>
                
                <div class="form-inline">
                    <g:form action="index" method="GET">
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="搜索用户名..." value="${params.q}">
                            <div class="input-group-append">
                                <button class="btn btn-outline-secondary" type="submit">
                                    <i class="fa fa-search"></i> 搜索
                                </button>
                            </div>
                        </div>
                    </g:form>
                </div>
            </div>
            
            <div class="card user-table-container mb-4">
                <div class="card-body p-0">
                    <table class="table table-striped mb-0 user-table">
                        <thead>
                            <tr>
                                <th width="5%">ID</th>
                                <th width="20%">用户名</th>
                                <th width="25%">状态</th>
                                <th width="30%">角色</th>
                                <th width="20%">操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${users}" var="user">
                                <tr>
                                    <td>${user.id}</td>
                                    <td class="username-cell">
                                        ${user.username}
                                    </td>
                                    <td>
                                        <g:if test="${user.enabled}">
                                            <span class="badge badge-success">
                                                <i class="fa fa-check-circle"></i> 启用
                                            </span>
                                        </g:if>
                                        <g:else>
                                            <span class="badge badge-danger">
                                                <i class="fa fa-ban"></i> 禁用
                                            </span>
                                        </g:else>
                                        
                                        <g:if test="${user.accountLocked}">
                                            <span class="badge badge-warning">
                                                <i class="fa fa-lock"></i> 锁定
                                            </span>
                                        </g:if>
                                        <g:if test="${user.accountExpired}">
                                            <span class="badge badge-warning">
                                                <i class="fa fa-calendar-times"></i> 账号过期
                                            </span>
                                        </g:if>
                                        <g:if test="${user.passwordExpired}">
                                            <span class="badge badge-warning">
                                                <i class="fa fa-key"></i> 密码过期
                                            </span>
                                        </g:if>
                                    </td>
                                    <td>
                                        <g:each in="${user.authorities}" var="role">
                                            <span class="badge badge-info badge-role">
                                                <i class="fa fa-tag"></i> ${role.authority.replace('ROLE_', '')}
                                            </span>
                                        </g:each>
                                        <g:if test="${!user.authorities}">
                                            <span class="text-muted">
                                                <i class="fa fa-exclamation-circle"></i> 无角色
                                            </span>
                                        </g:if>
                                    </td>
                                    <td class="action-buttons">
                                        <div class="btn-group" role="group">
                                            <g:link action="show" id="${user.id}" class="btn btn-info btn-sm" title="查看">
                                                <i class="fa fa-eye"></i> 查看
                                            </g:link>
                                            <g:link action="edit" id="${user.id}" class="btn btn-primary btn-sm" title="编辑">
                                                <i class="fa fa-edit"></i> 编辑
                                            </g:link>
                                            <g:link action="delete" id="${user.id}" class="btn btn-danger btn-sm" 
                                                    onclick="return confirm('确定要删除此用户吗?');" title="删除">
                                                <i class="fa fa-trash"></i> 删除
                                            </g:link>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>
                            <g:if test="${!users}">
                                <tr>
                                    <td colspan="5" class="empty-message">
                                        <i class="fa fa-info-circle"></i>
                                        <p class="mb-0">没有找到用户记录</p>
                                        <g:if test="${params.q}">
                                            <p class="mb-0 mt-2">
                                                找不到与 "${params.q}" 匹配的用户
                                                <g:link action="index" class="btn btn-sm btn-outline-secondary mt-2">
                                                    <i class="fa fa-list"></i> 查看所有用户
                                                </g:link>
                                            </p>
                                        </g:if>
                                    </td>
                                </tr>
                            </g:if>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="pagination-container d-flex justify-content-center">
                <g:paginate total="${usersCount ?: 0}" params="${params}" />
            </div>
        </div>
    </div>
</body>
</html> 