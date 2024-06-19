//
//  TasksRepository.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 18.06.2024.
//

import Foundation
import RealmSwift

final class TasksRepository {
    
    let service = TasksService()
    
    func save(_ task: TaskObject) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(
                    TaskObject.self,
                    value: task,
                    update: .all
                )
            }
        } catch {
            print(error)
        }
    }
    
    func fetchAllLocal() -> [TaskObject] {
        do {
            let realm = try Realm()
            return Array(realm.objects(TaskObject.self))
        } catch {
            print(error)
            return []
        }
    }
    
    func fetchRemote(completion: @escaping ([TaskObject]) -> Void) {
        service.loadRemoteTasks() { tasks in
            for task in tasks {
                self.save(task)
                completion(self.fetchAllLocal())
            }
        }
    }
    
    func uploadTask(_ task: TaskObject, completion: @escaping(Bool) -> Void) {
        service.uploadTask(task: task) { success in
            if success {
                self.save(task)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func deleteTask(id: Int) {
        do {
            let realm = try Realm()
            let task = realm.object(ofType: TaskObject.self,
                                       forPrimaryKey: id)
            if let task {
                service.removeTask(task: task)
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
            let task = realm.object(ofType: TaskObject.self,
                                       forPrimaryKey: id)
            if let task {
                try realm.write {
                    task.completed = !task.completed
                    uploadTask(task) { _ in
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func removeAllLocal() {
        let realm = try! Realm()
        try! realm.write {
          realm.deleteAll()
        }
    }
}
