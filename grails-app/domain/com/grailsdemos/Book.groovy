package com.grailsdemos

class Book {
    String title
    String author
    String isbn
    Date releaseDate
    String category
    BigDecimal price
    
    static constraints = {
        title(blank: false)
        author(blank: false)
        isbn(blank: false, unique: true)
        releaseDate(nullable: true)
        category(inList: ["Fiction", "Non-fiction", "Biography", "Technology", "Other"])
        price(min: 0.0)
    }
    
    String toString() {
        title
    }
} 