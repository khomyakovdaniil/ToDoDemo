//
//  Date+ToString.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 18.06.2024.
//

import Foundation

extension Date { 
    func toString() -> String { // Returns date as string, no time
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("dd MMM")
        return formatter.string(from: self)
    }
}
