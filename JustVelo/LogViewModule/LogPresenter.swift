//
//  LogPresenter.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 23.09.2021.
//

import UIKit

class LogPresenter: LogViewPresenterProtocol {
   
    var storageManager: StorageManager!

    weak var view: LogViewProtocol?
    
    var reversedSorting = true
    
    required init(view: LogViewProtocol, storageManager: StorageManager) {
        self.view = view
        self.storageManager = storageManager
    }
    
    func sortTrainings(by: SortingOptions) {
        guard let trainings = storageManager.trainings.value else { return }
        switch by {
        case .date:
            var sortedData = trainings.sorted(by: { $0.date! < $1.date! })
            if reversedSorting {
                sortedData = trainings.sorted(by: { $0.date! > $1.date! })
            }
            reloadData(trainings: sortedData)
        case .calories:
            print("Sort by calories")
        case .distance:
            var sortedData = trainings.sorted(by: { $0.distance! < $1.distance! })
            if reversedSorting {
                sortedData = trainings.sorted(by: { $0.distance! > $1.distance! })
            }
            reloadData(trainings: sortedData)
        case .time:
            print("Sort by time")
        }
    }
    
    func reloadData(trainings: [Training]) {
        self.view?.reloadData(trainings: trainings)
    }
}

enum SortingOptions: CaseIterable {
    case date
    case calories
    case distance
    case time
}
