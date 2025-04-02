package com.grailsdemos

import grails.gorm.transactions.Transactional
import groovy.util.logging.Slf4j

@Slf4j
class BootStrap {

    def init = { servletContext ->
        log.info("开始初始化应用程序...")
        try {
            initRolesAndUsers()
            log.info("应用程序初始化成功")
        } catch (Exception e) {
            log.error("应用程序初始化失败", e)
        }
    }
    
    @Transactional
    void initRolesAndUsers() {
        log.info("开始初始化角色和用户...")
        
        // 创建默认角色
        def adminRole = Role.findByAuthority('ROLE_ADMIN') 
        if (!adminRole) {
            adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
            log.info("创建了管理员角色 ROLE_ADMIN")
        }
        
        def userRole = Role.findByAuthority('ROLE_USER')
        if (!userRole) {
            userRole = new Role(authority: 'ROLE_USER').save(flush: true)
            log.info("创建了用户角色 ROLE_USER")
        }
        
        // 创建管理员用户
        def adminUser = User.findByUsername('admin')
        if (!adminUser) {
            adminUser = new User(
                username: 'admin',
                password: 'admin123',
                enabled: true,
                accountExpired: false,
                accountLocked: false,
                passwordExpired: false
            ).save(flush: true)
            log.info("创建了管理员用户 admin")
        }
        
        // 如果还没有分配角色，则分配管理员角色
        if (!UserRole.exists(adminUser.id, adminRole.id)) {
            UserRole.create(adminUser, adminRole, true)
            log.info("为管理员用户分配了 ROLE_ADMIN 角色")
        }
        
        // 如果还没有分配角色，也分配用户角色
        if (!UserRole.exists(adminUser.id, userRole.id)) {
            UserRole.create(adminUser, userRole, true)
            log.info("为管理员用户分配了 ROLE_USER 角色")
        }
        
        // 创建普通用户
        def normalUser = User.findByUsername('user')
        if (!normalUser) {
            normalUser = new User(
                username: 'user',
                password: 'user123',
                enabled: true,
                accountExpired: false,
                accountLocked: false,
                passwordExpired: false
            ).save(flush: true)
            log.info("创建了普通用户 user")
        }
        
        // 分配普通用户角色
        if (!UserRole.exists(normalUser.id, userRole.id)) {
            UserRole.create(normalUser, userRole, true)
            log.info("为普通用户分配了 ROLE_USER 角色")
        }
        
        log.info("角色和用户初始化完成，管理员用户名: admin，密码: admin123，普通用户名: user，密码: user123")
    }
    
    def destroy = {
        log.info("应用程序关闭中...")
    }
}