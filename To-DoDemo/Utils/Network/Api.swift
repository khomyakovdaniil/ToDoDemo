//
//  Api.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 19.06.2024.
//

import Foundation
import Moya

enum Api: TargetType {
    
    case getTasks
    case removeTask(_ task: TaskObject)
    case updateTask(_ task: TaskObject)
    
  // 1
  public var baseURL: URL {
      return URL(string: "https://tododemo-393dc-default-rtdb.firebaseio.com/\(UserSetting.getUserName().dropLast(10))")!
  }

  // 2
  public var path: String {
    switch self {
    case .getTasks: 
        "/tasks.json"
    case .removeTask(let task):
        "/tasks/\(task.id).json"
    case .updateTask(let task):
        "/tasks/\(task.id).json"
    }
  }

  // 3
  public var method: Moya.Method {
    switch self {
    case .getTasks: 
        return .get
    case .removeTask:
        return .delete
    case .updateTask:
        return .put
    }
  }

  // 4
  public var sampleData: Data {
    return Data()
  }

  // 5
  public var task: Task {
      switch self {
      case .getTasks, .removeTask:
          return .requestPlain
      case .updateTask(id: let task):
          return .requestParameters(parameters: [
                                    "id": task.id,
                                    "title": task.title,
                                    "textDescription": task.textDescription,
                                    "date": task.date.description,
                                    "completed": task.completed
                                    ],
                                    encoding: JSONEncoding.default)
      }
   
  }

  // 6
  public var headers: [String: String]? {
    return ["Content-Type": "application/json; charset=UTF-8"]
  }

  // 7
  public var validationType: ValidationType {
    return .successCodes
  }
}

