//
//  DataMockup.swift
//  CitiesTests
//
//  Created by Cửu Long Hoàng on 24/09/2022.
//

import Foundation
@testable import Cities

class DataMockup {
    static var cities = [
        CityModel(country: "US", name: "Alabama", id: 1, coord: CityCoordinateModel(lon: 0.00, lat: 0.00)),
        CityModel(country: "US", name: "Albuquerque", id: 2, coord: CityCoordinateModel(lon: 0.00, lat: 0.00)),
        CityModel(country: "US", name: "Anaheim", id: 3, coord: CityCoordinateModel(lon: 0.00, lat: 0.00)),
        CityModel(country: "US", name: "Arizona", id: 4, coord: CityCoordinateModel(lon: 0.00, lat: 0.00)),
        CityModel(country: "AU", name: "Sydney", id: 5, coord: CityCoordinateModel(lon: 0.00, lat: 0.00)),
    ]
}
