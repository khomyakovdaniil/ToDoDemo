//
//  TasksRepository.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 18.06.2024.
//

import Foundation
import RealmSwift

final class TasksRepository {
    
    func save(_ task: Task) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(
                    Task.self,
                    value: task,
                    update: .all
                )
            }
        } catch {
            print(error)
        }
    }
    
    func fetchAllLocal() -> [Task] {
        do {
            let realm = try Realm()
            return Array(realm.objects(Task.self))
        } catch {
            print(error)
            return []
        }
    }
    
    func deleteTask(id: Int) {
        do {
            let realm = try Realm()
            let task = realm.object(ofType: Task.self,
                                       forPrimaryKey: id)
            if let task {
                try realm.write {
                    realm.delete(task)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func completeTask(id: Int) {
        do {
            let realm = try Realm()
            let task = realm.object(ofType: Task.self,
                                       forPrimaryKey: id)
            if let task {
                try realm.write {
                    task.completed = !task.completed
                }
            }
        } catch {
            print(error)
        }
    }
}
