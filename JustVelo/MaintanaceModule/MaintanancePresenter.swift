//
//  MaintanancePresenter.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 07.10.2021.
//

import UIKit

protocol MaintananceViewProtocol: AnyObject {
    
}

protocol MaintanancePresenterProtocol: AnyObject {
    init(view: MaintananceViewProtocol)
}

class MaintanancePresenter: MaintanancePresenterProtocol {

    weak var view: MaintananceViewProtocol?
    
    required init(view: MaintananceViewProtocol) {
        self.view = view
    }
}
