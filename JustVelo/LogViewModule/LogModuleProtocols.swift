//
//  Protocols.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 20.10.2021.
//

import Foundation

protocol LogViewProtocol: AnyObject {
    func reloadData(trainings: [Training])
    
}

protocol LogViewPresenterProtocol: AnyObject {
    
    var storageManager: StorageManager! { get }
    init(view: LogViewProtocol, storageManager: StorageManager)
    var reversedSorting: Bool { get set }
    func reloadData(trainings: [Training])
    func sortTrainings(by: SortingOptions)
}
