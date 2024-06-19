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
    static let kIsLoggedKey = "isLoggedIn"
    
    static func getSortedByResult() -> Bool {
        defaults.bool(forKey: kSortedByResultKey)
    }
    
    static func setSortedByResult(_ value: Bool) {
        defaults.set(value, forKey: kSortedByResultKey)
    }
    
    static func setIsLogged(_ isLoged: Bool) {
        defaults.set(isLoged, forKey: self.kIsLoggedKey)
    }

    static func getIsLogged() -> Bool {
        defaults.bool(forKey: self.kIsLoggedKey)
    }
}
