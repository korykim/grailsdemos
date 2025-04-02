package com.grailsdemos

import grails.gorm.transactions.Transactional

@Transactional
class PostService {

    Post get(Serializable id) {
        return Post.get(id)
    }

    List<Post> list(Map args) {
        return Post.list(args)
    }

    Long count() {
        return Post.count()
    }

    void delete(Serializable id) {
        Post.get(id)?.delete()
    }

    Post save(Post post) {
        post.save()
        return post
    }

    List<Post> search(String query, Map args) {
        if (!query) {
            return list(args)
        }
        
        return Post.createCriteria().list(args) {
            or {
                ilike('title', "%${query}%")
                ilike('content', "%${query}%")
            }
            order('dateCreated', 'desc')
        }
    }
}