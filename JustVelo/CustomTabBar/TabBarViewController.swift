//
//  TabBarViewController.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 07.10.2021.
//

import UIKit

enum TabItem: String, CaseIterable {
    case map = "map"
    case log = "log"
    case maintain = "maintain"
    case settings = "settings"
    var viewController: UIViewController {
        switch self {
        case .map:
            return ModuleBuilder.createMapModule()
        case .log:
            return ModuleBuilder.createLogModule()
        case .maintain:
            return ModuleBuilder.createMaintenanceModule()
        case .settings:
            return ModuleBuilder.createMSettingsModule()
        }
    }
    // these can be your icons
    var icon: UIImage {
        switch self {
        case .map:
            return UIImage(systemName: "map.fill")!
        case .log:
            return UIImage(systemName: "list.bullet.indent")!
        case .maintain:
            return UIImage(systemName: "gear")!
        case .settings:
            return UIImage(systemName: "gearshape")!
        }
    }
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}

class NavigationMenuBaseController: UITabBarController {
    var customTabBar: TabNavigationMenu!
    var tabBarHeight: CGFloat = 78.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
    }
    
    func loadTabBar() {
        let tabItems: [TabItem] = TabItem.allCases
        self.setupCustomTabMenu(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        self.selectedIndex = 0
    }
    
    func setupCustomTabMenu(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
        let frame = tabBar.frame
        var controllers = [UIViewController]()
        tabBar.isHidden = true
        self.customTabBar = TabNavigationMenu(menuItems: menuItems, frame: frame)
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.customTabBar.clipsToBounds = true
        self.customTabBar.itemTapped = self.changeTab
        self.view.addSubview(customTabBar)
        NSLayoutConstraint.activate([
            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            self.customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
            self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])
        for i in 0 ..< menuItems.count {
            controllers.append(menuItems[i].viewController)
        }
        self.view.layoutIfNeeded()
        completion(controllers)
    }
    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}
