//
//  SettingsView.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 07.10.2021.
//

import UIKit

class SettingsView: UIViewController, SettingsViewProtocol {
    
    var presenter: SettingsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    
}
