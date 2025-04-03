package com.grailsdemos

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class NoteServiceSpec extends Specification {

    NoteService noteService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Note(...).save(flush: true, failOnError: true)
        //new Note(...).save(flush: true, failOnError: true)
        //Note note = new Note(...).save(flush: true, failOnError: true)
        //new Note(...).save(flush: true, failOnError: true)
        //new Note(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //note.id
    }

    void "test get"() {
        setupData()

        expect:
        noteService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Note> noteList = noteService.list(max: 2, offset: 2)

        then:
        noteList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        noteService.count() == 5
    }

    void "test delete"() {
        Long noteId = setupData()

        expect:
        noteService.count() == 5

        when:
        noteService.delete(noteId)
        sessionFactory.currentSession.flush()

        then:
        noteService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Note note = new Note()
        noteService.save(note)

        then:
        note.id != null
    }
}
