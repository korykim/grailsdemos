<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>用户注册</title>
    <style type="text/css">
        .register-form {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background: #f9f9f9;
        }
        .register-form h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn-register {
            width: 100%;
            padding: 10px;
            background: #5cb85c;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-register:hover {
            background: #449d44;
        }
        .login-link {
            text-align: center;
            margin-top: 15px;
        }
        .error-message {
            color: #d9534f;
            font-size: 12px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-form">
            <h2>用户注册</h2>
            
            <g:if test="${flash.message}">
                <div class="alert alert-info">${flash.message}</div>
            </g:if>
            
            <g:hasErrors bean="${command}">
                <div class="alert alert-danger">
                    <g:renderErrors bean="${command}" as="list" />
                </div>
            </g:hasErrors>
            
            <g:form action="register" method="POST">
                <div class="form-group">
                    <label for="username">用户名</label>
                    <input type="text" class="form-control" name="username" id="username" 
                           value="${command?.username}" placeholder="请输入用户名" required />
                    <g:hasErrors bean="${command}" field="username">
                        <div class="error-message"><g:fieldError bean="${command}" field="username" /></div>
                    </g:hasErrors>
                    <small class="form-text text-muted">用户名长度3-20个字符，只能包含字母、数字和下划线</small>
                </div>
                
                <div class="form-group">
                    <label for="password">密码</label>
                    <input type="password" class="form-control" name="password" id="password" placeholder="请输入密码" required />
                    <g:hasErrors bean="${command}" field="password">
                        <div class="error-message"><g:fieldError bean="${command}" field="password" /></div>
                    </g:hasErrors>
                    <small class="form-text text-muted">密码长度至少6个字符</small>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">确认密码</label>
                    <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="请再次输入密码" required />
                    <g:hasErrors bean="${command}" field="confirmPassword">
                        <div class="error-message"><g:fieldError bean="${command}" field="confirmPassword" /></div>
                    </g:hasErrors>
                </div>
                
                <button type="submit" class="btn-register">注册</button>
            </g:form>
            
            <div class="login-link">
                <p>已有账号？<g:link controller="login">立即登录</g:link></p>
            </div>
        </div>
    </div>
</body>
</html> 