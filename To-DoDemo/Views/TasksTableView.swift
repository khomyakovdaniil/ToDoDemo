//
//  TasksTableView.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 17.06.2024.
//

import UIKit

final class TasksTableView: UITableView {

    // MARK: - Init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        registerCells()
        backgroundColor = .systemBackground
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setting up
    func registerCells() {
        register(TaskTableViewCell.self,
                 forCellReuseIdentifier: TaskTableViewCell.identifier())
    }
}
