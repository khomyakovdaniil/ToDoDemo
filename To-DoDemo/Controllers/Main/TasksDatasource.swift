//
//  TasksDatasource.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 18.06.2024.
//

import UIKit

final class TasksDataSource: NSObject, UITableViewDataSource {
    
    var tasks: [TaskObject] = []
    
    override init() {
        super.init()
    }

    // MARK: - UITableviewDatasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentTask = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:  TaskTableViewCell.identifier(), for: indexPath) as! TaskTableViewCell
        cell.setCell(task: currentTask)
        return cell
    }

}
