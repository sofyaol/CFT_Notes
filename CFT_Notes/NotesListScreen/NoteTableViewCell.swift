//
//  NoteTableViewCell.swift
//  CFT_Notes
//
//  Created by Sofya Olekhnovich on 11.02.2024.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    static let height: CGFloat = 70
    static let reuseIdentifier = "NoteTableViewCell"
    
    // MARK: - UI Elements
    
    lazy var baseView: UIView = {
       var baseView = UIView()
        baseView.layer.cornerRadius = 10
        return baseView
    }()
    
    lazy var arrow: UIImageView = {
        let arrow = UIImageView(image: UIImage(systemName: "chevron.forward"))
        arrow.tintColor = .white
        return arrow
    }()
    
    lazy var title: UILabel = {
        var title = UILabel()
        title.numberOfLines = 1
        title.font = .systemFont(ofSize: 16, weight: .bold)
        title.lineBreakMode = .byTruncatingTail
        title.adjustsFontSizeToFitWidth = false
        title.setContentHuggingPriority(.defaultHigh, for: .vertical)
        title.textColor = .primaryNoteCellTitle
        return title
    }()
    
    lazy var date: UILabel = {
        var date = UILabel()
        date.numberOfLines = 0
        date.font = .systemFont(ofSize: 16, weight: .light)
        date.lineBreakMode = .byTruncatingTail
        date.setContentHuggingPriority(.defaultHigh, for: .vertical)
        date.textColor = .secondaryNoteCellTitle
        return date
    }()
    
    // MARK: - Functions
    
    func configure(note: Note, color: UIColor) {
        baseView.backgroundColor = color
        selectionStyle = .none
        title.text = note.title
        let dateString = note.creationDate.formatted(CommonUIConstants.dateFormatStyle)
        date.text = "\(CommonUIConstants.creationDateTitlePrefix)\(dateString)"
        
        setupViews()
    }
    
    private func setupViews() {
       
        baseView.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(baseView)
        contentView.addSubview(arrow)
        contentView.addSubview(title)
        contentView.addSubview(date)

        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])

        NSLayoutConstraint.activate([
            arrow.centerYAnchor.constraint(equalTo: baseView.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50)
            
        ])
        
        NSLayoutConstraint.activate([
            date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            date.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5)
        ])
    }
}



