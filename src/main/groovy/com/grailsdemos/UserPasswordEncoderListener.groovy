package com.grailsdemos

import grails.plugin.springsecurity.SpringSecurityService
import org.grails.datastore.mapping.engine.event.AbstractPersistenceEvent
import org.grails.datastore.mapping.engine.event.PreInsertEvent
import org.grails.datastore.mapping.engine.event.PreUpdateEvent
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.ApplicationListener
import groovy.transform.CompileStatic

@CompileStatic
class UserPasswordEncoderListener implements ApplicationListener<AbstractPersistenceEvent> {

    @Autowired
    SpringSecurityService springSecurityService

    @Override
    void onApplicationEvent(AbstractPersistenceEvent event) {
        if (event.entityObject instanceof User) {
            if (event instanceof PreInsertEvent || event instanceof PreUpdateEvent) {
                encodePasswordForEvent(event)
            }
        }
    }

    private void encodePasswordForEvent(AbstractPersistenceEvent event) {
        User u = event.entityObject as User
        if (u.password && ((event instanceof PreInsertEvent) || (event instanceof PreUpdateEvent && u.isDirty('password')))) {
            event.getEntityAccess().setProperty('password', encodePassword(u.password))
        }
    }

    private String encodePassword(String password) {
        springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }
}
