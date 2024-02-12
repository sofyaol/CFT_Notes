//
//  NotesListViewModel.swift
//  CFT_Notes
//
//  Created by Sofya Olekhnovich on 11.02.2024.
//

import Foundation

class NotesListViewModel {
    
    weak var coordinator: AppCoordinator?
    weak var viewDelegate: NotesListViewDelegate?
    var notes: [Note]
    var lastEditedNoteIndex  = 0
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        notes = NotesListViewModel.getNotes()
    }
    
    private static func getNotes() -> [Note] {
        if let notes = SQLiteDatabase.shared.getRows() {
            return notes
        }
        SQLiteDatabase.shared.createTable()
        var note = Note.getDefaultInstance(withId: 0)
        guard let id = SQLiteDatabase.shared.insertRow(note) else { return [Note]() }
        note.id = id
        return [note]
    }
    
    func createNewNote() {
        var note = Note.getDefaultInstance(withId: 0)
        lastEditedNoteIndex = notes.count
        notes.append(note)
        guard let id = SQLiteDatabase.shared.insertRow(note) else { return }
        note.id = id
        coordinator?.createNote(note)
    }
    
    func editNote(at indexPath: IndexPath) {
        lastEditedNoteIndex = indexPath.row
        coordinator?.editNote(notes[indexPath.row])
    }
    
    func deleteNote(at indexPath: IndexPath) {
        SQLiteDatabase.shared.deleteRow(id: notes[indexPath.row].id)
        notes.remove(at: indexPath.row)
    }
    
    func updateNoteValues(_ note: Note) {
        notes[lastEditedNoteIndex] = note
        viewDelegate?.updateNotesList()
    }
}
