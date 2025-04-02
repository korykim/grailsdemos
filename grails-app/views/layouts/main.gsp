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

    <g:layoutHead/>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-static-top" role="navigation">
    <div class="container-fluid">
        <a class="navbar-brand" href="/#"><asset:image src="grails.svg" alt="Grails Logo"/></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" aria-expanded="false" style="height: 0.8px;" id="navbarContent">
            <ul class="nav navbar-nav ml-auto">
                <sec:ifLoggedIn>
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <li class="nav-item">
                            <g:link controller="userManagement" action="index" class="nav-link">用户管理</g:link>
                        </li>
                    </sec:ifAllGranted>
                </sec:ifLoggedIn>
                <sec:ifNotLoggedIn>
                    <li class="nav-item">
                        <g:link controller="login" class="nav-link">登录</g:link>
                    </li>
                    <li class="nav-item">
                        <g:link controller="register" class="nav-link">注册</g:link>
                    </li>
                </sec:ifNotLoggedIn>
                <sec:ifLoggedIn>
                    <li class="nav-item">
                        <span class="nav-link">欢迎, <sec:username/></span>
                    </li>
                    <li class="nav-item">
                        <g:link controller="logout" class="nav-link">注销</g:link>
                    </li>
                </sec:ifLoggedIn>
                <g:pageProperty name="page.nav"/>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
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

<div class="footer" role="contentinfo">
    <div class="container-fluid">
        <div class="row">
            <div class="col">
                <a href="https://guides.grails.org" target="_blank">
                    <asset:image src="advancedgrails.svg" alt="Grails Guides" class="float-left"/>
                </a>
                <strong class="centered"><a href="https://guides.grails.org" target="_blank">Grails Guides</a></strong>
                <p>Building your first Grails app? Looking to add security, or create a Single-Page-App? Check out the <a href="https://guides.grails.org" target="_blank">Grails Guides</a> for step-by-step tutorials.</p>

            </div>
            <div class="col">
                <a href="https://docs.grails.org" target="_blank">
                    <asset:image src="documentation.svg" alt="Grails Documentation" class="float-left"/>
                </a>
                <strong class="centered"><a href="https://docs.grails.org" target="_blank">Documentation</a></strong>
                <p>Ready to dig in? You can find in-depth documentation for all the features of Grails in the <a href="https://docs.grails.org" target="_blank">User Guide</a>.</p>

            </div>
            <div class="col">
                <a href="https://slack.grails.org" target="_blank">
                    <asset:image src="slack.svg" alt="Grails Slack" class="float-left"/>
                </a>
                <strong class="centered"><a href="https://slack.grails.org" target="_blank">Join the Community</a></strong>
                <p>Get feedback and share your experience with other Grails developers in the community <a href="https://slack.grails.org" target="_blank">Slack channel</a>.</p>
            </div>
        </div>
    </div>
</div>

<div id="spinner" class="spinner" style="display:none;">
    <g:message code="spinner.alt" default="Loading&hellip;"/>
</div>

<asset:javascript src="application.js"/>

</body>
</html>
