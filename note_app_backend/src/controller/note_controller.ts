import express from 'express'
import { getDatabase } from '../config/mongodb_client'
import { Note } from '../models/note_model'
import { ObjectId } from 'mongodb'

export class NoteController {
    static async addNote (request: express.Request, response: express.Response) {
        const note: Note = request.body
        let db = getDatabase()
        let noteCollection = db.collection("notes")
        note.createAt = Date.now()
        const data = await noteCollection.insertOne(note)

        response.status(200).json({
            "status": "success",
            "response": data
        })
    }

    static async getMyNotes (request: express.Request, response: express.Response) {
        const uid = request.query.uid

        let db = getDatabase()
        let noteCollection = db.collection('notes')

        const notes = await noteCollection.find({
            "creatorId": uid
        }).toArray()

        response.status(200).json({
            "status": "success",
            "response": notes
        })
    }


    static async updateNote (request: express.Request, response: express.Response) {
        const note: Note = request.body
        let db = getDatabase()
        let noteCollection = db.collection("notes")
        note.createAt = Date.now()
        const updateNoteOject = {
            title: note.title,
            description: note.description,
            createAt: note.createAt
        }
        const data = await noteCollection.updateOne({ _id: new ObjectId(note.noteId.toString()) }, { $set: updateNoteOject })
        response.status(200).json({
            "status": "success",
            "response": data
        })
    }


    static async deleteNote (request: express.Request, response: express.Response) {
        const note: Note = request.body
        let db = getDatabase()
        let noteCollection = db.collection("notes")


        const data = await noteCollection.deleteOne({ _id: new ObjectId(note.noteId.toString()) })


        response.status(200).json({
            "status": "success",
            "response": data
        })
    }
}