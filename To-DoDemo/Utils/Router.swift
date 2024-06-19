//
//  Router.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 19.06.2024.
//

import Foundation
import UIKit

final class Router: NSObject {
    
    static var window: UIWindow?
    
    static func setRootViewController() {
        DispatchQueue.main.async {
            if UserSetting.getIsLogged() {
                let controller = TasksListViewController(tasksRepository: TasksRepository())
                let navController = UINavigationController(rootViewController: controller)
                window?.rootViewController = navController
                window?.makeKeyAndVisible()
            } else {
                let startViewController = StartViewController()
                let navController = UINavigationController(rootViewController: startViewController)
                window?.rootViewController = navController
                window?.makeKeyAndVisible()
            }
        }
    }
}
