//
//  TasksService.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 19.06.2024.
//

import Foundation
import Moya

class TasksService {
    
    let provider = MoyaProvider<Api>()
    
    func loadRemoteTasks(completion: @escaping ([TaskObject]) -> Void) {
        provider.request(.getTasks) { result in

            switch result {
            case .success(let response):
              do {
                  guard let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any] else {
                      return
                  }
                  let dGroup = DispatchGroup()
                  var tasks: [TaskObject] = []
                  for object in json {
                      dGroup.enter()
                      guard let task = object.value as? [String: Any] else {
                          return
                      }
                      let taskObject = self.decodeTaskObject(from: task)
                      tasks.append(taskObject)
                      dGroup.leave()
                  }
                  dGroup.notify(queue: .main) {
                      completion(tasks)
                  }
                  print("success")
              } catch {
                print(error)
              }
            case .failure(let error):
              print(error)
            }
        }
    }
    
    func uploadTask(task: TaskObject, completion: @escaping (Bool) -> Void) {
        provider.request(.updateTask(task)) { result in
            switch result {
            case .success(let response):
                completion(true)
            case .failure(let error):
                completion(false)
            }
        }
    }
    
    func removeTask(task: TaskObject) {
        provider.request(.removeTask(task)) { result in
            switch result {
            case .success(let response):
                do {
                    print(try response.mapJSON())
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func decodeTaskObject(from dict: [String : Any]) -> TaskObject { // TODO: refactor as proper decoder
        let taskObject = TaskObject()
        taskObject.id = dict["id"] as? Int ?? 0
        taskObject.completed = dict["completed"] as? Bool ?? false
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        taskObject.date = formatter.date(from: dict["date"] as? String ?? "") ?? Date()
        taskObject.title = dict["title"] as? String ?? ""
        taskObject.textDescription = dict["textDescription"] as? String ?? ""
        return taskObject
    }
}
