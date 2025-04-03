package com.grailsdemos

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class NoteController {

    NoteService noteService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond noteService.list(params), model:[noteCount: noteService.count()]
    }

    def show(Long id) {
        respond noteService.get(id)
    }

    def create() {
        respond new Note(params)
    }

    def save(Note note) {
        if (note == null) {
            notFound()
            return
        }

        try {
            noteService.save(note)
        } catch (ValidationException e) {
            respond note.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'note.label', default: 'Note'), note.id])
                redirect note
            }
            '*' { respond note, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond noteService.get(id)
    }

    def update(Note note) {
        if (note == null) {
            notFound()
            return
        }

        try {
            noteService.save(note)
        } catch (ValidationException e) {
            respond note.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'note.label', default: 'Note'), note.id])
                redirect note
            }
            '*'{ respond note, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        noteService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'note.label', default: 'Note'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'note.label', default: 'Note'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
