package com.grailsdemos

import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.SpringSecurityService

class UserManagementService {

    SpringSecurityService springSecurityService
    
    /**
     * 获取所有用户列表
     */
    def listUsers(Map params) {
        return [users: User.list(params), usersCount: User.count()]
    }
    
    /**
     * 搜索用户
     */
    def searchUsers(String query, Map params) {
        if (!query) {
            return listUsers(params)
        }
        
        def users = User.createCriteria().list(params) {
            ilike('username', "%${query}%")
        }
        
        def totalCount = User.createCriteria().count {
            ilike('username', "%${query}%")
        }
        
        return [users: users, usersCount: totalCount]
    }
    
    /**
     * 根据ID获取用户
     */
    def getUser(Long id) {
        return User.get(id)
    }
    
    /**
     * 新建或更新用户
     */
    @Transactional
    def saveUser(User user, Map params) {
        // 处理密码更新（如果提供了新密码）
        if (params.newPassword) {
            user.password = params.newPassword
        }
        
        def saved = user.save(flush: true)
        
        if (saved) {
            // 处理角色更新
            UserRole.removeAll(user)
            
            if (params.roleIds) {
                params.list('roleIds').each { roleId ->
                    def role = Role.get(roleId)
                    if (role) {
                        UserRole.create(user, role, true)
                    }
                }
            }
        }
        
        return saved
    }
    
    /**
     * 删除用户
     */
    @Transactional
    def deleteUser(Long id) {
        def user = User.get(id)
        if (!user) {
            return [success: false, message: "用户不存在"]
        }
        
        try {
            // 删除用户角色关联
            UserRole.removeAll(user)
            // 删除用户
            user.delete(flush: true)
            return [success: true, message: "用户删除成功"]
        } catch (Exception e) {
            return [success: false, message: "删除用户失败: ${e.message}"]
        }
    }
    
    /**
     * 获取所有角色
     */
    def listRoles() {
        return Role.list()
    }
} 