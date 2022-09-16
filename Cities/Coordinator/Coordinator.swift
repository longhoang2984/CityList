//
//  Coordinator.swift
//  Cities
//
//  Created by Cửu Long Hoàng on 16/09/2022.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ return $0 !== coordinator })
    }
}
