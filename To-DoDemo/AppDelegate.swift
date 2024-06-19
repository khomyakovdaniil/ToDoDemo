//
//  AppDelegate.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 17.06.2024.
//

import UIKit
import FirebaseCore
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        makeMigrationIfNeeded()
        return true
    }

}

extension AppDelegate {
    private func makeMigrationIfNeeded() { // Realm migration block
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration,oldSchemaVersion in
                
            }
            )
        Realm.Configuration.defaultConfiguration = config
    }
}


