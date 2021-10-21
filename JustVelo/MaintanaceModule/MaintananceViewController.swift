//
//  MaintananceView.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 07.10.2021.
//

import UIKit

class MaintananceView: UIViewController, MaintananceViewProtocol {
    
    var presenter: MaintanancePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
}
