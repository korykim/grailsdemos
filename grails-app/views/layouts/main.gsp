<!doctype html>
<html lang="en" class="no-js" xmlns:sec="http://www.springframework.org/security/tags">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

    <asset:stylesheet src="application.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .hover-bg-primary:hover {
            background-color: rgba(0, 123, 255, 0.5) !important;
        }
        .navbar-dark .navbar-nav .nav-link {
            color: rgba(255, 255, 255, 0.9);
            display: flex;
            align-items: center;
            height: 40px;
            padding-top: 0;
            padding-bottom: 0;
        }
        .navbar-dark .navbar-nav .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        .dropdown-menu {
            margin-top: 8px;
        }
        .navbar-nav {
            display: flex;
            align-items: center;
            height: 60px;
        }
        .navbar-nav .nav-item {
            display: flex;
            align-items: center;
            height: 40px;
        }
        .nav-link.btn-danger {
            height: 38px;
            margin-top: 0;
            margin-bottom: 0;
        }
        .navbar {
            min-height: 60px;
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .container-fluid.mt-4 {
            flex: 1;
        }
         
    </style>

    <g:layoutHead/>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-static-top" role="navigation">
    <div class="container-fluid">
        <a class="navbar-brand" href="/#"><asset:image src="grails.svg" alt="Grails Logo" style="height: 40px;"/></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" aria-expanded="false" style="height: 0.8px;" id="navbarContent">
            <ul class="nav navbar-nav ml-auto d-flex align-items-center">
                <sec:ifLoggedIn>
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <li class="nav-item mx-2">
                            <g:link controller="userManagement" action="index" class="nav-link px-3 rounded-pill d-flex align-items-center">
                                <i class="fas fa-users mr-1"></i>用户管理
                            </g:link>
                        </li>
                         <li class="nav-item mx-2">
                            <g:link controller="book" action="index" class="nav-link px-3 rounded-pill d-flex align-items-center">
                                <i class="fas fa-book mr-1"></i>书籍管理
                            </g:link>
                        </li>
                        <li class="nav-item dropdown mx-2">
                            <a class="nav-link dropdown-toggle px-3 rounded-pill d-flex align-items-center" href="#" id="blogDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-blog mr-1"></i>博客管理
                            </a>
                            <div class="dropdown-menu dropdown-menu-right bg-dark border-0 shadow" aria-labelledby="blogDropdown">
                                <g:link controller="post" action="index" class="dropdown-item text-white hover-bg-primary py-2">
                                    <i class="fas fa-file-alt mr-2"></i>文章管理
                                </g:link>
                                <div class="dropdown-divider bg-secondary"></div>
                                <g:link controller="category" action="index" class="dropdown-item text-white hover-bg-primary py-2">
                                    <i class="fas fa-folder mr-2"></i>分类管理
                                </g:link>
                                <div class="dropdown-divider bg-secondary"></div>
                                <g:link controller="tag" action="index" class="dropdown-item text-white hover-bg-primary py-2">
                                    <i class="fas fa-tags mr-2"></i>标签管理
                                </g:link>
                            </div>
                        </li>
                    </sec:ifAllGranted>
                </sec:ifLoggedIn>
                <sec:ifNotLoggedIn>
                    <li class="nav-item mx-2">
                        <g:link controller="login" class="nav-link px-3 rounded-pill d-flex align-items-center">
                            <i class="fas fa-sign-in-alt mr-1"></i>登录
                        </g:link>
                    </li>
                    <li class="nav-item mx-2">
                        <g:link controller="register" class="nav-link px-3 rounded-pill d-flex align-items-center">
                            <i class="fas fa-user-plus mr-1"></i>注册
                        </g:link>
                    </li>
                </sec:ifNotLoggedIn>
                <sec:ifLoggedIn>
                    <li class="nav-item mx-2">
                        <span class="nav-link px-3 d-flex align-items-center">
                            <i class="fas fa-user-circle mr-1"></i>欢迎, <sec:username/>
                        </span>
                    </li>
                    <li class="nav-item mx-2">
                        <g:link controller="logout" class="nav-link px-3 rounded-pill btn-danger text-white d-flex align-items-center">
                            <i class="fas fa-sign-out-alt mr-1"></i>注销
                        </g:link>
                    </li>
                </sec:ifLoggedIn>
                <g:pageProperty name="page.nav"/>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid mt-4">
    <g:if test="${flash.message}">
        <div class="alert alert-info">${flash.message}</div>
    </g:if>
    <g:if test="${flash.error}">
        <div class="alert alert-danger">${flash.error}</div>
    </g:if>
    <g:if test="${flash.success}">
        <div class="alert alert-success">${flash.success}</div>
    </g:if>
    
    <g:layoutBody/>
</div>

<div id="spinner" class="spinner" style="display:none;">
    <g:message code="spinner.alt" default="Loading&hellip;"/>
</div>

<asset:javascript src="application.js"/>

<div class="footer" role="contentinfo">
    
    <div class="footer-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <p class="mb-0">&copy; <script>document.write(new Date().getFullYear())</script> Grails框架 | 本站使用Grails <g:meta name="info.app.grailsVersion"/> 构建</p>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
