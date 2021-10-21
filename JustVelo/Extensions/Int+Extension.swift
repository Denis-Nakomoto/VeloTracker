//
//  Int+Extension.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 21.10.2021.
//

import Foundation

extension Int {
    static func parse(from string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
