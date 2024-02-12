//
//  AppCoordinator.swift
//  CFT_Notes
//
//  Created by Sofya Olekhnovich on 11.02.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var notesListViewModel: NotesListViewModel?
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        notesListViewModel = NotesListViewModel(coordinator: self)
    }
    
    func start() {
        let notesList = NotesListViewController(viewModel: notesListViewModel!)
        window.rootViewController = navigationController
        navigationController.pushViewController(notesList, animated: false)
        window.makeKeyAndVisible()
    }
    
    func createNote(_ note: Note) {
        let editNoteViewModel = EditNoteViewModel(coordinator: self, note: note)
        let editNoteViewController = EditNoteViewController(viewModel: editNoteViewModel)
        navigationController.pushViewController(editNoteViewController, animated: true)
    }
    
    func editNote(_ note: Note) {
        let editNoteViewModel = EditNoteViewModel(coordinator: self, note: note)
        let editNoteViewController = EditNoteViewController(viewModel: editNoteViewModel)
        navigationController.pushViewController(editNoteViewController, animated: true)
    }
    
    func updateNote(_ note: Note) {
        notesListViewModel?.updateNoteValues(note)
    }
}

