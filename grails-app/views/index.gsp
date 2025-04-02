<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>欢迎访问 - Grails示例网站</title>
    <style>
        .hero-section {
            background: linear-gradient(135deg, #343a40 0%, #1e2124 100%);
            color: white;
            padding: 80px 0;
            margin-bottom: 40px;
        }
        .feature-box {
            background: white;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .feature-box:hover {
            transform: translateY(-5px);
        }
        .feature-icon {
            font-size: 2.5rem;
            color: #17a2b8;
            margin-bottom: 20px;
        }
        .stat-box {
            background: rgba(23, 162, 184, 0.1);
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            margin-bottom: 30px;
        }
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #17a2b8;
        }
        .latest-section {
            background: #f8f9fa;
            padding: 60px 0;
            margin: 40px 0;
        }
        .card {
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body>
    <!-- 英雄区域 -->
    <div class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-4 mb-4">欢迎来到Grails示例网站</h1>
                    <p class="lead mb-4">这是一个使用Grails框架构建的现代化Web应用示例，展示了博客系统、用户管理和图书管理等功能。</p>
                    <sec:ifNotLoggedIn>
                        <div class="mt-4">
                            <g:link controller="register" class="btn btn-primary btn-lg mr-3">
                                <i class="fas fa-user-plus mr-2"></i>立即注册
                            </g:link>
                            <g:link controller="login" class="btn btn-outline-light btn-lg">
                                <i class="fas fa-sign-in-alt mr-2"></i>登录
                            </g:link>
                        </div>
                    </sec:ifNotLoggedIn>
                </div>
                <div class="col-md-4 text-center">
                    <asset:image src="grails.svg" alt="Grails Logo" width="200" class="img-fluid"/>
                </div>
            </div>
        </div>
    </div>

    <!-- 功能特色区域 -->
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="feature-box text-center">
                    <div class="feature-icon">
                        <i class="fas fa-blog"></i>
                    </div>
                    <h3>博客系统</h3>
                    <p>支持文章发布、分类管理和标签功能，让您轻松管理和分享内容。</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box text-center">
                    <div class="feature-icon">
                        <i class="fas fa-book"></i>
                    </div>
                    <h3>图书管理</h3>
                    <p>完整的图书管理系统，支持图书信息的添加、编辑和分类管理。</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box text-center">
                    <div class="feature-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3>用户管理</h3>
                    <p>强大的用户管理功能，包括用户注册、角色分配和权限控制。</p>
                </div>
            </div>
        </div>
    </div>

    <!-- 统计数据区域 -->
    <div class="latest-section">
        <div class="container">
            <h2 class="text-center mb-5">网站统计</h2>
            <div class="row">
                <div class="col-md-3">
                    <div class="stat-box">
                        <div class="stat-number">${grailsApplication.controllerClasses.size()}</div>
                        <div class="stat-label">控制器数量</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-box">
                        <div class="stat-number">${grailsApplication.serviceClasses.size()}</div>
                        <div class="stat-label">服务类数量</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-box">
                        <div class="stat-number">${grailsApplication.domainClasses.size()}</div>
                        <div class="stat-label">领域类数量</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-box">
                        <div class="stat-number">${grailsApplication.tagLibClasses.size()}</div>
                        <div class="stat-label">标签库数量</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 技术栈展示 -->
    <div class="container mb-5">
        <h2 class="text-center mb-5">技术栈</h2>
        <div class="row">
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body text-center">
                        <i class="fab fa-java fa-3x text-primary mb-3"></i>
                        <h5 class="card-title">Java</h5>
                        <p class="card-text">基于JVM的强大后端支持</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body text-center">
                        <i class="fas fa-code fa-3x text-success mb-3"></i>
                        <h5 class="card-title">Groovy</h5>
                        <p class="card-text">灵活的动态编程语言</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body text-center">
                        <i class="fab fa-bootstrap fa-3x text-info mb-3"></i>
                        <h5 class="card-title">Bootstrap</h5>
                        <p class="card-text">响应式前端框架</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body text-center">
                        <i class="fas fa-database fa-3x text-warning mb-3"></i>
                        <h5 class="card-title">数据库</h5>
                        <p class="card-text">强大的ORM支持</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
