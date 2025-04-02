<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${gspLayout ?: 'main'}"/>
    <title>用户登录</title>
    <style type="text/css">
        .login-form {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background: #f9f9f9;
        }
        .login-form h2 {
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
        .btn-login {
            width: 100%;
            padding: 10px;
            background: #337ab7;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-login:hover {
            background: #286090;
        }
        .checkbox {
            margin-top: 10px;
        }
        .register-link {
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-form">
            <h2>用户登录</h2>
            
            <g:if test="${flash.message}">
                <div class="alert alert-info">${flash.message}</div>
            </g:if>
            
            <form action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" autocomplete="off">
                <div class="form-group">
                    <label for="username">用户名</label>
                    <input type="text" class="form-control" name="${usernameParameter ?: 'username'}" id="username" placeholder="请输入用户名" required />
                </div>
                
                <div class="form-group">
                    <label for="password">密码</label>
                    <input type="password" class="form-control" name="${passwordParameter ?: 'password'}" id="password" placeholder="请输入密码" required />
                </div>
                
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="${rememberMeParameter ?: 'remember-me'}" id="remember_me" /> 记住我
                    </label>
                </div>
                
                <button type="submit" class="btn-login">登录</button>
            </form>
            
            <div class="register-link">
                <p>没有账号？<g:link controller="register">立即注册</g:link></p>
            </div>
        </div>
    </div>
</body>
</html> 