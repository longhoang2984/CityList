//
//  CitiesTests.swift
//  CitiesTests
//
//  Created by Cửu Long Hoàng on 14/09/2022.
//

import XCTest
import RxSwift
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

class CityViewModelTests: XCTestCase {
    let bag = DisposeBag()
    func test_init_city_view_model() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.cities.count, 5)
    }
    
    func test_search_by_prefix_should_return_one_city_matched() {
        let prefix = "alb"
        
        let sut = makeSUT()
        sut.searchBy(prefix: prefix)
        
        var count = 0
        let expect = expectation(description: "wait")
        sut.list.subscribe { cities in
            count = cities.element?.count ?? 0
            expect.fulfill()
        }.disposed(by: bag)
        waitForExpectations(timeout: 0.1)
        XCTAssertEqual(count, 1)
    }
    
    func test_search_by_prefix_should_return_five_city_matched() {
        let prefix = "a"
        
        let sut = makeSUT()
        sut.searchBy(prefix: prefix)
        
        var count = 0
        var city: CityModel?
        let expect = expectation(description: "wait")
        sut.list.subscribe { cities in
            count = cities.element?.count ?? 0
            city = cities.element?.first(where: { $0.name == "Sydney" })
            expect.fulfill()
        }.disposed(by: bag)
        waitForExpectations(timeout: 0.1)
        XCTAssertEqual(count, 5)
        XCTAssertNotNil(city)
    }
    
    func makeSUT() -> CityViewModel {
        return CityViewModel(cities: DataMockup.cities)
    }
}

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

class MockCityService: GithubService {
    var showError: Bool
    init(showError: Bool = false) {
        self.showError = showError
    }
    
    override func getCityList() -> Observable<CitiesResponse> {
        if showError {
            return Observable.error(NSError(domain: "city-url-domain", code: 404, userInfo: ["message": "URL not found"]))
        } else {
            return Observable<CitiesResponse>.just(DataMockup.cities)
        }
    }
}
