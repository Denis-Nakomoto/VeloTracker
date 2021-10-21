//
//  UIButton+Extension.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 30.09.2021.
//

import UIKit

extension UIButton {
    
    convenience init(title: String,
                     opacity: Float = 0.7,
                     cornerRadius: CGFloat = 10,
                     textColor: UIColor = .black,
                     backgroundColor: UIColor = .blue,
                     isHidden: Bool = true) {
        self.init()
        self.setTitle(title, for: .normal)
        self.layer.opacity = opacity
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.textColor = textColor
        self.backgroundColor = backgroundColor
        self.isHidden = isHidden
    }
}


