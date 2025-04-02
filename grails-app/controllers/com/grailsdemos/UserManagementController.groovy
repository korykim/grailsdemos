package com.grailsdemos

import grails.plugin.springsecurity.annotation.Secured
import grails.gorm.transactions.Transactional

@Secured('ROLE_ADMIN')
class UserManagementController {
    
    def userManagementService
    
    def index() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        // 处理搜索查询
        def query = params.q
        def result
        
        if (query) {
            // 根据用户名搜索
            result = userManagementService.searchUsers(query, params)
        } else {
            result = userManagementService.listUsers(params)
        }
        
        [users: result.users, usersCount: result.usersCount, params: params]
    }
    
    def show(Long id) {
        def user = userManagementService.getUser(id)
        if (!user) {
            flash.message = "用户不存在"
            redirect(action: "index")
            return
        }
        
        [user: user, roles: userManagementService.listRoles(), userRoles: user.authorities]
    }
    
    def edit(Long id) {
        def user = userManagementService.getUser(id)
        if (!user) {
            flash.message = "用户不存在"
            redirect(action: "index")
            return
        }
        
        [user: user, roles: userManagementService.listRoles(), userRoles: user.authorities]
    }
    
    @Transactional
    def update(Long id) {
        def user = userManagementService.getUser(id)
        if (!user) {
            flash.message = "用户不存在"
            redirect(action: "index")
            return
        }
        
        // 更新基本信息
        user.properties = params
        
        if (!userManagementService.saveUser(user, params)) {
            render(view: "edit", model: [user: user, roles: userManagementService.listRoles(), userRoles: user.authorities])
            return
        }
        
        flash.message = "用户更新成功"
        redirect(action: "show", id: user.id)
    }
    
    def create() {
        [user: new User(params), roles: userManagementService.listRoles()]
    }
    
    def save() {
        def user = new User(params)
        
        if (!userManagementService.saveUser(user, params)) {
            render(view: "create", model: [user: user, roles: userManagementService.listRoles()])
            return
        }
        
        flash.message = "用户创建成功"
        redirect(action: "show", id: user.id)
    }
    
    def delete(Long id) {
        def result = userManagementService.deleteUser(id)
        
        if (result.success) {
            flash.message = result.message
            redirect(action: "index")
        } else {
            flash.message = result.message
            redirect(action: "show", id: id)
        }
    }
} 