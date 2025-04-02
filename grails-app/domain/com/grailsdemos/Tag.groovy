package com.grailsdemos

class Tag {
    String name
    Date dateCreated
    Date lastUpdated
    
    // 关系定义
    static belongsTo = Post
    static hasMany = [posts: Post]
    
    static constraints = {
        name(blank: false, unique: true, maxSize: 30)
    }
    
    static mapping = {
        sort name: "asc"
    }
    
    String toString() {
        name
    }
} 