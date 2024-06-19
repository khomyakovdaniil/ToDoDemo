//
//  Constants.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 18.06.2024.
//

import Foundation

struct Constants {
    
    struct Strings {
        static let addAction = "Add"
        static let logOutAction = "Log out"
        static let sortedByDate = "Sorted: date"
        static let sortedByResult = "Sorted: completion"
        static let helpText = "Tap \"Add\" to add task, swipe right to complete task, swipe left to remove task"
        static let completeAction = "Complete"
        static let deleteAction = "Delete"
        static let saveAction =  "Save"
    }
    
    struct Alerts {
        static let error = "Error"
        static let ok = "Ok"
        static let wrongPasswordTitle = "Password Incorrect"
        static let wrongPasswordMessage = "Please re-type password"
        static let passwordRecoverySent = "Password recovery email sent"
        static let success = "Success"
        static let userCreatedMessage = "User created, you can login now"
    }
}
