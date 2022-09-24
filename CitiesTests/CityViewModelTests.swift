//
//  CityViewModelTests.swift
//  CitiesTests
//
//  Created by Cửu Long Hoàng on 24/09/2022.
//

import XCTest
import RxSwift
@testable import Cities

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
        
        let count = CityListSpy(sut.list).citiesResponse.count
        XCTAssertEqual(count, 1)
    }
    
    func test_search_by_prefix_should_return_five_city_matched() {
        let prefix = "a"
        
        let sut = makeSUT()
        sut.searchBy(prefix: prefix)
        
        let cities = CityListSpy(sut.list).citiesResponse
        let count = cities.count
        let city: CityModel? = cities.first(where: { $0.name == "Sydney" })
        XCTAssertEqual(count, 5)
        XCTAssertNotNil(city)
    }
    
    func makeSUT() -> CityViewModel {
        return CityViewModel(cities: DataMockup.cities)
    }
}
