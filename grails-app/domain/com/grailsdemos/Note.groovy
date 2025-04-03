package com.grailsdemos

class Note {
    String title
    String content
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        title(blank: false)
        content(blank: false)
        dateCreated(nullable: true)
        lastUpdated(nullable: true)
    }
    
    String toString() {
        title
    }
} 