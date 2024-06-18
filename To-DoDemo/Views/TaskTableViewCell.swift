//
//  TaskTableViewCell.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 18.06.2024.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    //Constants
    private let kStandartSpacing = 8.0
    
    // MARK: - Cell elements
    
    internal let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.semibold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    internal let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.textColor = .secondaryLabel
        return label
    }()
    
    internal let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.textColor = .label
        return label
    }()
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        let constraints = [
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: kStandartSpacing),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -kStandartSpacing),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: kStandartSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: kStandartSpacing),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: kStandartSpacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -kStandartSpacing),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -kStandartSpacing)
        ]
        NSLayoutConstraint.activate(constraints)
        contentView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setCell(task: Task) {
        titleLabel.text = task.title
        descriptionLabel.text = task.textDescription
        dateLabel.text = task.date.toString()
        backgroundColor = task.completed ? .green : .clear
    }
}
