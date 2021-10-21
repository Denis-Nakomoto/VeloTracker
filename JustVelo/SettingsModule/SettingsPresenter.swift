//
//  SettingsPresenter.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 07.10.2021.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    
}

protocol SettingsPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol)
}

class SettingsPresenter: SettingsPresenterProtocol {

    weak var view: SettingsViewProtocol?
    
    required init(view: SettingsViewProtocol) {
        self.view = view
    }
}
