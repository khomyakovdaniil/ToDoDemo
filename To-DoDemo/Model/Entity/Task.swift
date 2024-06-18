//
//  Task.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 17.06.2024.
//

import Foundation
import RealmSwift

final class Task: Object {
    
    @objc dynamic var id: Int = UUID().hashValue
    @objc dynamic var title: String = "Title"
    @objc dynamic var textDescription: String = "Description"
    @objc dynamic var date: Date = Date()
    @objc dynamic var completed: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
