//
//  LogViewContentConfiguration.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 20.10.2021.
//

import UIKit

struct LogViewContentConfiguration: UIContentConfiguration, Hashable {
    
    var distance: String?
    var date: Date?
    var pathPassed: Data?
    var nameColor: UIColor?
    var contentBackgroundColor: UIColor?
    
    
    func makeContentView() -> UIView & UIContentView {
        return LogContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        
        // Perform update on parameters that does not related to cell's data itesm
        
        // Make sure we are dealing with instance of UICellConfigurationState
        guard let state = state as? UICellConfigurationState else {
            return self
        }

        // Updater self based on the current state
        var updatedConfiguration = self
        if state.isSelected {
            updatedConfiguration.nameColor = .white
            updatedConfiguration.contentBackgroundColor = .systemBlue
        } else {
            updatedConfiguration.nameColor = .systemBlue
            updatedConfiguration.contentBackgroundColor = .systemBackground
        }

        return updatedConfiguration
    }

}
