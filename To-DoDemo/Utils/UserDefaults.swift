//
//  UserDefaults.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 18.06.2024.
//

import Foundation

final class UserSetting { // Helper class to access UserDefaults, doesn't store anything, no instance needed
    
    static let defaults = UserDefaults.standard
    
    static let kSortedByResultKey = "filteredByResult"
    
    static func getSortedByResult() -> Bool {
        return defaults.bool(forKey: kSortedByResultKey)
    }
    
    static func setSortedByResult(_ value: Bool) {
        defaults.set(value, forKey: kSortedByResultKey)
    }
}
