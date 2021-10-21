//
//  String+extension.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 30.09.2021.
//

import Foundation

extension Double {
    
    func distanceFarmatter() -> String {
        if self >= 1000 {
            let kilometers = Int(self / 1000)
            let meters = Int(self) - kilometers * 1000
            return "\(kilometers)km \(meters)m"
        } else {
            return "\(Int(self))m"
        }
    }
}
