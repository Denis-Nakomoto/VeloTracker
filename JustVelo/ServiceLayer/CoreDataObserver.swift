//
//  Observer.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 01.10.2021.
//

import Foundation

class Observer {
    var value: [Training]? {
        didSet {
            observerBlock?(value)
        }
    }
    
    init(value: [Training]) {
        self.value = value
    }
    var observerBlock: (([Training]?) -> Void)?
    
    func add(_ observer: @escaping ([Training]?) -> Void) {
        self.observerBlock = observer
    }
}
