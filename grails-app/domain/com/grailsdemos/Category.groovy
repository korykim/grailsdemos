package com.grailsdemos

class Category {
    String name
    String description
    Date dateCreated
    Date lastUpdated
    
    // 关系定义
    static hasMany = [posts: Post]
    
    static constraints = {
        name(blank: false, unique: true, maxSize: 50)
        description(nullable: true, maxSize: 500)
    }
    
    static mapping = {
        sort name: "asc"
    }
    
    String toString() {
        name
    }
} 