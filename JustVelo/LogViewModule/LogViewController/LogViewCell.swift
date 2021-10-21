//
//  LogViewCell.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 01.10.2021.
//

import UIKit

class LogViewCell: UICollectionViewListCell {
    
    var training: Training?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        
        var newConfiguration = LogViewContentConfiguration().updated(for: state)

        newConfiguration.distance = training?.distance
        newConfiguration.date = training?.date
        newConfiguration.pathPassed = training?.pathPassed

        contentConfiguration = newConfiguration
    }
    
}
