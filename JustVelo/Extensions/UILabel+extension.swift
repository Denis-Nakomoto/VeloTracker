//
//  UILabel+extension.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 22.09.2021.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .boldSystemFont(ofSize: 18), color: UIColor = .white) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = color
        self.numberOfLines = 1
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
    }
}
