<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'post.label', default: 'Post')}" />
        <title>搜索结果 - ${query}</title>
    </head>
    <body>
    <div id="content" role="main">
        <div class="container">
            <section class="row">
                <a href="#list-post" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
                <div class="nav" role="navigation">
                    <ul>
                        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                        <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                    </ul>
                </div>
            </section>
            <section class="row">
                <div id="list-post" class="col-12 content scaffold-list" role="main">
                    <h1>搜索结果: "${query}"</h1>
                    
                    <!-- 搜索表单 -->
                    <div class="search-box mb-4">
                        <g:form action="search" method="GET" class="form-inline">
                            <div class="input-group">
                                <g:textField name="query" value="${query}" class="form-control" placeholder="搜索标题或内容..." />
                                <div class="input-group-append">
                                    <button class="btn btn-primary" type="submit">搜索</button>
                                </div>
                            </div>
                        </g:form>
                    </div>
                    
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    
                    <g:if test="${postCount == 0}">
                        <div class="alert alert-info">没有找到匹配"${query}"的结果</div>
                    </g:if>
                    <g:else>
                        <div class="alert alert-success">找到 ${postCount} 个匹配结果</div>
                        <f:table collection="${postList}" />
                    </g:else>

                    <g:if test="${postCount > params.int('max')}">
                    <div class="pagination">
                        <g:paginate total="${postCount ?: 0}" action="search" params="[query: query]" />
                    </div>
                    </g:if>
                </div>
            </section>
        </div>
    </div>
    </body>
</html> 