//
//  TasksListViewController.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 17.06.2024.
//

import UIKit

final class TasksListViewController: UIViewController {
    
    // MARK: - Views
    private let tasksTableView = TasksTableView()
    private let helperLabel = UILabel() // Displays instructions for user
    
    // MARK: - Dependencies
    private let tasksRepository: TasksRepository // Used to manage tasks, network layer can be added
    
    // MARK: - Properties
    private let datasource = TasksDataSource() // Used by tableview
    private var sortedByDate = true // Boolean to store filter, binded to UserDefaults
    
    // MARK: - Init
    init(tasksRepository: TasksRepository) {
        self.tasksRepository = tasksRepository
        self.sortedByDate = !UserSetting.getSortedByResult()
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tasksRepository.fetchRemote() { tasks in
            self.datasource.tasks = tasks
            self.sortTasks()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) { // Reloads tasks list each time the view appears
        datasource.tasks = tasksRepository.fetchAllLocal()
        sortTasks()
    }
}


// MARK: - UI
extension TasksListViewController {
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupTasksTableView()
        setupHelperLabel()
    }
    
    private func setupNavigationBar() {
        let addTaskButton = UIBarButtonItem(title: Constants.Strings.addAction,
                                            style: .plain,
                                            target: self,
                                            action: #selector(addTask)
        )
        let logOutButton = UIBarButtonItem(title: Constants.Strings.logOutAction,
                                            style: .plain,
                                            target: self,
                                            action: #selector(logOut)
        )
        let switchFilterButton = UIBarButtonItem(title: Constants.Strings.sortedByDate,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(switchFilter))
        navigationItem.rightBarButtonItems = [addTaskButton, logOutButton]
        navigationItem.leftBarButtonItem = switchFilterButton
    }
    
    private func setupTasksTableView() {
        tasksTableView.dataSource = datasource
        tasksTableView.delegate = self // Delegate to self, to handle user input and initate changes in repository
        view.addSubview(tasksTableView)
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tasksTableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tasksTableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tasksTableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupHelperLabel() {
        helperLabel.translatesAutoresizingMaskIntoConstraints = false
        helperLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        helperLabel.numberOfLines = 2
        helperLabel.textAlignment = .center
        helperLabel.textColor = .secondaryLabel
        helperLabel.text = Constants.Strings.helpText
        view.addSubview(helperLabel)
        let constraints = [
            helperLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            helperLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            helperLabel.topAnchor.constraint(equalTo: tasksTableView.bottomAnchor),
            helperLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
// MARK: - TableViewDelegate
extension TasksListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openTask(for: indexPath) // Opens TaskViewController with chosen task
    }
    
    @objc func openTask(for indexPath: IndexPath?) {
        let taskViewController = TaskViewController()
        taskViewController.tasksRepository = tasksRepository
        if let indexPath = indexPath {
            // We create a copy of a Task to avoid changing the realm object directly
            let task = datasource.tasks[indexPath.row]
            let tTask = TaskObject()
            tTask.id = task.id
            tTask.title = task.title
            tTask.textDescription = task.textDescription
            tTask.date = task.date
            tTask.completed = task.completed
            taskViewController.task = tTask
        }
        self.navigationController?.pushViewController(taskViewController, animated: false)
    }
    
    // Task completion action on swipe right
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title:  Constants.Strings.completeAction, handler: { [weak self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            guard let self else { return }
            let task = datasource.tasks[indexPath.row]
            tasksRepository.completeTask(id: task.id)
            self.datasource.tasks = self.tasksRepository.fetchAllLocal()
            sortTasks()
            success(true)
        })
        completeAction.backgroundColor = .green
        
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    // Task removal action on swipe left
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title:  Constants.Strings.deleteAction, handler: { [weak self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            guard let self else { return }
            let task = self.datasource.tasks[indexPath.row]
            self.tasksRepository.deleteTask(id: task.id)
            self.datasource.tasks = self.tasksRepository.fetchAllLocal()
            sortTasks()
            success(true)
        })
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
// MARK: - Functions
extension TasksListViewController {
    
    @objc func addTask() {
        openTask(for: nil) // Opens TaskViewController with empty task
    }
    
    @objc func switchFilter() {
        sortedByDate.toggle()
        sortTasks()
        UserSetting.setSortedByResult(!sortedByDate)
    }
    
    @objc func logOut() {
        UserSetting.setIsLogged(false)
        tasksRepository.removeAllLocal()
        Router.setRootViewController()
    }
    
    private func sortTasks() {
        if sortedByDate {
            datasource.tasks.sort(by: { $0.date < $1.date })
            tasksTableView.reloadData()
            self.navigationItem.leftBarButtonItem?.title = Constants.Strings.sortedByDate
            
        } else {
            datasource.tasks.sort(by: { $0.completed && !$1.completed })
            tasksTableView.reloadData()
            self.navigationItem.leftBarButtonItem?.title = Constants.Strings.sortedByResult
        }
    }
}
