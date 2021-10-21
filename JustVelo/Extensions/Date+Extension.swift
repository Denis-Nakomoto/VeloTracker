//
//  DateFormatter.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 20.10.2021.
//

import Foundation

extension Date {
    
    func dateFormatter() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        return formatter.string(from: self)
    }
    
}
