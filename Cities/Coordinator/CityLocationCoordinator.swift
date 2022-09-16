//
//  CityLocationCoordinator.swift
//  Cities
//
//  Created by Cửu Long Hoàng on 16/09/2022.
//

import Foundation
import UIKit

class CityLocationCoordinator: BaseCoordinator {
    
    private var navigationController: UINavigationController?
    private var city: CityModel!
    
    init(navigationController: UINavigationController?, city: CityModel) {
        self.navigationController = navigationController
        self.city = city
    }
    
    override func start() {
        let viewModel = CityLocationViewModel(city: city)
        let vc = CityLocationViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
