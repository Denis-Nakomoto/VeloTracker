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
        guard let state = state as? UICellConfigurationState else {
            return self
        }

        // Updater self based on the current state
        var updatedConfiguration = self
        if state.isHighlighted {
            updatedConfiguration.nameColor = .white
            updatedConfiguration.contentBackgroundColor = .systemBlue
        } else {
            updatedConfiguration.nameColor = .systemBlue
            updatedConfiguration.contentBackgroundColor = .systemBackground
        }

        return updatedConfiguration
    }

}
