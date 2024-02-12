//
//  EditNoteViewController.swift
//  CFT_Notes
//
//  Created by Sofya Olekhnovich on 11.02.2024.
//

import UIKit

class EditNoteViewController: BaseViewController {
    
    private var viewModel: EditNoteViewModel
    
    // MARK: - Inits
    
    init(viewModel: EditNoteViewModel) {
        self.viewModel = viewModel
        super.init(needLargeTitle: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    
    lazy var textView: UITextView = {
        var text = UITextView()
        text.font = UIFont.systemFont(ofSize: 16)
        text.text = viewModel.note.text
        return text
    }()
    
    lazy var titleView: UITextView = {
       var title = UITextView()
        title.text = viewModel.note.title
        title.textColor = .black
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 24)
        title.delegate = self
        return title
    }()
    
    lazy var separator: UIView = {
        var separator = UIView()
        separator.backgroundColor = .lightGray
        return separator
    }()
    
    
    // MARK: - Override funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleView)
        view.addSubview(separator)
        view.addSubview(textView)
        
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setHeightForTextView(titleView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setTextViewFocused()
        setHeightForTextView(titleView)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)

        if parent == nil {
            viewModel.finishEditing(title: titleView.text, text: textView.text)
        }
    }
    
    // MARK: - Private funcs
    
    private func setTextViewFocused() {
        titleView.becomeFirstResponder()
    }
    
    private func setHeightForTextView(_ textView: UITextView) {
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = calculateHeightForTextView()
            }
        }
        
        func calculateHeightForTextView() -> CGFloat {
            let size = CGSize(width: textView.frame.width, height: .infinity)
            let estimatedSize = textView.sizeThatFits(size)
            return estimatedSize.height
        }
    }
    
    private func setConstraints() {
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.5)
        ])
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: separator.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITextViewDelegate

extension EditNoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == self.titleView {
            setHeightForTextView(textView)
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == titleView {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            
            return true
        }
        return false
    }

}

