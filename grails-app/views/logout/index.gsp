<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>注销确认</title>
    <style type="text/css">
        .logout-container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background: #f9f9f9;
            text-align: center;
        }
        .logout-container h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .logout-container p {
            margin-bottom: 20px;
        }
        .btn-logout {
            display: inline-block;
            padding: 10px 20px;
            background: #d9534f;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-logout:hover {
            background: #c9302c;
        }
        .btn-cancel {
            display: inline-block;
            margin-left: 10px;
            padding: 10px 20px;
            background: #f0ad4e;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-cancel:hover {
            background: #ec971f;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logout-container">
            <h2>注销确认</h2>
            
            <p>您确定要注销登录吗，${username}？</p>
            
            <g:link action="doLogout" class="btn-logout">确认注销</g:link>
            <g:link uri="/" class="btn-cancel">取消</g:link>
        </div>
    </div>
</body>
</html> 