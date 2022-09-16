//
//  AppCoordinator.swift
//  Cities
//
//  Created by Cửu Long Hoàng on 16/09/2022.
//

import Foundation
import UIKit
class AppCoordinator: BaseCoordinator {
    
    private (set) var window: UIWindow?
    init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        let navigationController = UINavigationController()
        let rootViewController = CityListViewController { cityModel in
            let coordinator = CityLocationCoordinator(navigationController: navigationController, city: cityModel)
            coordinator.start()
        }
        navigationController.pushViewController(rootViewController, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
