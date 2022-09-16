//
//  CitiesTests.swift
//  CitiesTests
//
//  Created by Cửu Long Hoàng on 14/09/2022.
//

import XCTest
@testable import Cities

class CitiesTests: XCTestCase {
    
    var cityNode: Trie!
    var countryNode: Trie!
    
    override func setUp() {
        super.setUp()
        cityNode = Trie()
        countryNode = Trie()
        let list = [
            CityModel(country: "US", name: "Alabama", id: 1, coord: CityCoordinateModel(lon: 0.00, lat: 0.00)),
            CityModel(country: "US", name: "Albuquerque", id: 2, coord: CityCoordinateModel(lon: 0.00, lat: 0.00)),
            CityModel(country: "US", name: "Anaheim", id: 3, coord: CityCoordinateModel(lon: 0.00, lat: 0.00)),
            CityModel(country: "US", name: "Arizona", id: 4, coord: CityCoordinateModel(lon: 0.00, lat: 0.00)),
            CityModel(country: "AU", name: "Sydney", id: 5, coord: CityCoordinateModel(lon: 0.00, lat: 0.00)),
        ]
        for city in list {
            cityNode.insert(key: city.name, city: city)
            countryNode.insert(key: city.country, city: city)
        }
    }
    
    func test_search_prefix_without_country_node() {
        let prefix = "alb"
        
        let result = cityNode.findCitiesWithPrefix(prefix)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Albuquerque")
    }
    
    func test_search_prefix_with_country_node() {
        
        let prefix = "a"
        
        let citiesFromCityNode = cityNode.findCitiesWithPrefix(prefix)
        let result = countryNode.findCitiesWithPrefix(prefix, filteredCityList: citiesFromCityNode) + citiesFromCityNode
        
        XCTAssertEqual(result.count, 5)
        XCTAssertNotNil(result.first(where: { $0.name == "Sydney" }))
    }
    
    override func tearDown() {
        super.tearDown()
        cityNode = nil
        countryNode = nil
    }
}
