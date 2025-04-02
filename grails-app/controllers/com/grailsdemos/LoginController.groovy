package com.grailsdemos

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.authentication.AccountExpiredException
import org.springframework.security.authentication.CredentialsExpiredException
import org.springframework.security.authentication.DisabledException
import org.springframework.security.authentication.LockedException
import org.springframework.security.web.WebAttributes

@Secured('permitAll')
class LoginController {

    def authenticationFailureHandler
    def authenticationSuccessHandler
    def springSecurityService

    /**
     * 显示登录页面
     */
    def index() {
        def conf = SpringSecurityUtils.securityConfig

        if (springSecurityService.isLoggedIn()) {
            redirect uri: conf.successHandler.defaultTargetUrl
            return
        }

        // 默认显示登录页面的Model
        [postUrl: conf.apf.filterProcessesUrl,
         rememberMeParameter: conf.rememberMe.parameter,
         usernameParameter: conf.apf.usernameParameter,
         passwordParameter: conf.apf.passwordParameter,
         gspLayout: conf.gsp.layoutAuth ?: 'main']
    }

    /**
     * 验证失败后的回调
     */
    def authFail() {
        String msg = ''
        Exception exception = session[WebAttributes.AUTHENTICATION_EXCEPTION]
        if (exception) {
            if (exception instanceof AccountExpiredException) {
                msg = '用户账号已过期'
            } else if (exception instanceof CredentialsExpiredException) {
                msg = '用户密码已过期'
            } else if (exception instanceof DisabledException) {
                msg = '用户账号已禁用'
            } else if (exception instanceof LockedException) {
                msg = '用户账号已锁定'
            } else {
                msg = '用户名或密码错误'
            }
        }

        flash.message = msg
        redirect action: 'index'
    }

    /**
     * 登录成功后的回调
     */
    def authSuccess() {
        // 清除会话中的错误信息
        if (session[WebAttributes.AUTHENTICATION_EXCEPTION]) {
            session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION)
        }

        // 记录登录成功信息
        flash.message = "欢迎回来，${springSecurityService.principal.username}！"

        // 重定向到默认成功页面
        redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
    }
} 