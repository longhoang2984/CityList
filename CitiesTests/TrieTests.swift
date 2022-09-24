//
//  TrieTests.swift
//  CitiesTests
//
//  Created by Cửu Long Hoàng on 14/09/2022.
//

import XCTest
import RxSwift
@testable import Cities

class TrieTests: XCTestCase {
    
    var cityNode: Trie!
    var countryNode: Trie!
    
    override func setUp() {
        super.setUp()
        cityNode = Trie()
        countryNode = Trie()
        let list = DataMockup.cities
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


