//
//  DefaultUIConstants.swift
//  CFT_Notes
//
//  Created by Sofya Olekhnovich on 11.02.2024.
//

import Foundation

struct CommonUIConstants {
    
    // MARK: - Layout constants

    static let horizontalFillPercent: CGFloat = 0.95
    
    static let addButtonSize: CGFloat = 60
    
    // MARK: - Text constants
    
    static let creationDateTitlePrefix: String = "Создано: "
    
    static let dateFormatStyle: Date.FormatStyle = .dateTime.day(.twoDigits)
                                        .month(.twoDigits)
                                        .year(.defaultDigits)
                                        .locale(Locale(identifier: "ru_RU"))
    
    static let NotesListTitle: String = "Заметки"
    
    static let defaultNoteTitle = "Новая заметка"
}
