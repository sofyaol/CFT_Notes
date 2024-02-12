//
//  Note.swift
//  CFT_Notes
//
//  Created by Sofya Olekhnovich on 11.02.2024.
//

import Foundation

struct Note {
    
    var id: Int64
    var title: String
    var text: String
    var creationDate: Date
}

extension Note {
    static func getDefaultInstance(withId id: Int64) -> Note {
        return Note(id: id, title: CommonUIConstants.defaultNoteTitle, text: "", creationDate: Date.now)
    }
}
