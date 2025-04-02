package com.grailsdemos

class Post {
    String title
    String content
    Date dateCreated
    Date lastUpdated
    Boolean published = false
    
    // 关系定义
    static belongsTo = [category: Category]
    static hasMany = [tags: Tag]
    
    static constraints = {
        title(blank: false, maxSize: 200)
        content(blank: false)
        published()
        category(nullable: false)
    }
    
    static mapping = {
        content type: 'text'
        sort dateCreated: "desc"
    }
    
    String toString() {
        title
    }
} 