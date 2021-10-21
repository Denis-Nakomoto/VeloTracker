//
//  UITableViewCell+Extension.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 01.10.2021.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseId: String {
        String(describing: self)
    }
    
    func removeViews() {
        contentView.subviews.forEach { $0.removeFromSuperview()}
    }
    
    func setupCardView() {
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        self.backgroundColor = .black
    }

}
