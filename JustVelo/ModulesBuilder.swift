//
//  ModulesBuilder.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 22.09.2021.
//

import UIKit

protocol Builder {
    static func createMapModule() -> UIViewController
    static func createLogModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMapModule() -> UIViewController {
        let locationManager = LocationManager()
        let view = MapViewController()
        let snapShotter = SnapShotter()
        let storageManager = StorageManager.shared
        let presenter = MapViewPresenter(view: view, locationManager: locationManager, snapShotter: snapShotter, storageManager: storageManager)
        view.presenter = presenter
        return view
    }
    
    static func createLogModule() -> UIViewController {
        let navigationController = UINavigationController()
        let logViewController = LogViewController()
        navigationController.pushViewController(logViewController, animated: true)
        let storageManager = StorageManager.shared
        let presenter = LogPresenter(view: logViewController, storageManager: storageManager)
        logViewController.presenter = presenter
        return navigationController
    }
    
    static func createMaintenanceModule() -> UIViewController {
        let view = MaintananceView()
        let presenter = MaintanancePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createMSettingsModule() -> UIViewController {
        let view = SettingsView()
        let presenter = SettingsPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
}
