//
//  NotesListViewController.swift
//  CFT_Notes
//
//  Created by Sofya Olekhnovich on 11.02.2024.
//

import UIKit

class NotesListViewController: BaseViewController {
    
    private var viewModel: NotesListViewModel
    
    init(viewModel: NotesListViewModel) {
        self.viewModel = viewModel
        super.init(needLargeTitle: true)
        viewModel.viewDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.reuseIdentifier)
        tableView.rowHeight = NoteTableViewCell.height
        tableView.indicatorStyle = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var addButton: UIButton = {
        var addButton = UIButton()
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .defaultScreenBackground
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = CommonUIConstants.addButtonSize / 2
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return addButton
    }()
    
    // MARK: - Override funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = CommonUIConstants.NotesListTitle
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc private func addButtonPressed() {
        viewModel.createNewNote()
    }
    
    // MARK: - Private funcs

    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(addButton)
        setConstraints()
    }
    
    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -20),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalToConstant: view.frame.width * CommonUIConstants.horizontalFillPercent)
        ])
        
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            addButton.widthAnchor.constraint(equalToConstant: CommonUIConstants.addButtonSize),
            addButton.heightAnchor.constraint(equalToConstant: CommonUIConstants.addButtonSize),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func getColorForNoteCell(at row: Int) -> UIColor {
        let index = row % UIColor.noteColors.count
        return UIColor.noteColors[index] ?? UIColor.magenta
    }
}

// MARK: - UITableViewDelegate && UITableViewDataSource

extension NotesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let noteCell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseIdentifier) as? NoteTableViewCell
        else {return UITableViewCell()}
        let cellColor = getColorForNoteCell(at: indexPath.row)
        noteCell.configure(note: viewModel.notes[indexPath.row], color: cellColor)
        return noteCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil){  [weak self] (action, view, completionHandler) in
            
            self?.viewModel.deleteNote(at: indexPath)
            tableView.beginUpdates ()
                    tableView.deleteRows (at: [indexPath], with: .automatic)
                    tableView.endUpdates()
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .defaultScreenBackground
        deleteAction.image = UIImage(systemName: "trash")?.withTintColor(.red, renderingMode: .alwaysOriginal)
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            configuration.performsFirstActionWithFullSwipe = false
            
            return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            viewModel.editNote(at: indexPath)
        }
}

extension NotesListViewController: NotesListViewDelegate {
    func updateNotesList() {
        tableView.reloadData()
    }
    
    
}


