//
//  SceneDelegate.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 17.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow.init(windowScene: scene)
        
        let controller = TasksListViewController(tasksRepository: TasksRepository())
        let navController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }


}

