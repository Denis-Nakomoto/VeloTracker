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
    
    func intToSMH() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        let formattedString = formatter.string(from: TimeInterval(self))!
        return formattedString
    }
    
    
//    func intToTimeString() -> String {
//        var string  = ""
//        if (0...59).contains(self) {
//            string = "\(self)s"
//        } else if (0...59).contains(self)
//    }
}
