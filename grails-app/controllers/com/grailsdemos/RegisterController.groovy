package com.grailsdemos

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import grails.gorm.transactions.Transactional

@Secured('ROLE_ADMIN')
class RegisterController {
    
    def springSecurityService
    
    def index() {
        [command: new RegisterCommand()]
    }
    
    @Transactional
    def register(RegisterCommand command) {
        if (command.hasErrors()) {
            render view: 'index', model: [command: command]
            return
        }
        
        // 创建新用户
        def user = new User(
            username: command.username,
            password: command.password,
            enabled: true,
            accountExpired: false,
            accountLocked: false,
            passwordExpired: false
        )
        
        if (!user.save(flush: true)) {
            // 处理保存失败的情况
            command.errors.rejectValue("username", "user.username.unique")
            render view: 'index', model: [command: command]
            return
        }
        
        // 分配默认用户角色 ROLE_USER
        def userRole = Role.findByAuthority('ROLE_USER')
        UserRole.create(user, userRole, true)
        
        // 登录用户
        springSecurityService.reauthenticate(command.username)
        
        // 重定向到首页或成功页面
        flash.message = "注册成功，欢迎 ${command.username}！"
        redirect(uri: '/')
    }
}

// 注册命令对象
class RegisterCommand {
    String username
    String password
    String confirmPassword
    
    static constraints = {
        username blank: false, minSize: 3, maxSize: 20, matches: /[\w]+/, unique: true
        password blank: false, minSize: 6, maxSize: 64
        confirmPassword blank: false, validator: { val, obj ->
            val == obj.password ? true : 'register.password.mismatch'
        }
    }
} 