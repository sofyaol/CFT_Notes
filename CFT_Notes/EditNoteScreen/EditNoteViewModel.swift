//
//  EditNoteViewModel.swift
//  CFT_Notes
//
//  Created by Sofya Olekhnovich on 11.02.2024.
//

class EditNoteViewModel {
    
    var note: Note
    weak var coordinator: AppCoordinator?
    
    init(coordinator: AppCoordinator, note: Note) {
        self.coordinator = coordinator
        self.note = note
    }
    
    func finishEditing(title: String, text: String) {
        note.title = title == "" ? CommonUIConstants.defaultNoteTitle : title
        note.text = text
        _ = SQLiteDatabase.shared.updateRow(note)
        coordinator?.updateNote(note)
    }
}
