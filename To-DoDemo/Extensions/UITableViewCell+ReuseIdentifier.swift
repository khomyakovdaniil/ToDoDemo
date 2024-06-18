//
//  UITableViewCell+ReuseIdentifier.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 18.06.2024.
//

import UIKit

extension UITableViewCell {
    static func identifier() -> String { // Easier syntax for registering ad dequeing cells
        return NSStringFromClass(self)
    }
}
