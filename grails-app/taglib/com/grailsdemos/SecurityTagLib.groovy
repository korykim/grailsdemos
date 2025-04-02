package com.grailsdemos

import grails.plugin.springsecurity.SpringSecurityService
import org.springframework.beans.factory.annotation.Autowired

/**
 * 安全相关的标签库
 * 为视图提供安全检查和当前用户信息的快捷方式
 */
class SecurityTagLib {
    static namespace = 'sec'
    
    @Autowired
    SpringSecurityService springSecurityService
    
    /**
     * 用户已登录时显示内容
     * 示例: <sec:ifLoggedIn>显示给已登录用户的内容</sec:ifLoggedIn>
     */
    def ifLoggedIn = { attrs, body ->
        if (springSecurityService.isLoggedIn()) {
            out << body()
        }
    }
    
    /**
     * 用户未登录时显示内容
     * 示例: <sec:ifNotLoggedIn>显示给未登录用户的内容</sec:ifNotLoggedIn>
     */
    def ifNotLoggedIn = { attrs, body ->
        if (!springSecurityService.isLoggedIn()) {
            out << body()
        }
    }
    
    /**
     * 有指定角色权限时显示内容
     * 示例: <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_USER">有权限查看的内容</sec:ifAnyGranted>
     */
    def ifAnyGranted = { attrs, body ->
        String roles = attrs.roles
        if (roles) {
            if (springSecurityService.ifAnyGranted(roles)) {
                out << body()
            }
        }
    }
    
    /**
     * 显示当前登录用户名
     * 示例: 欢迎, <sec:username/>
     */
    def username = { attrs, body ->
        if (springSecurityService.isLoggedIn()) {
            out << springSecurityService.authentication.name
        }
    }
} 