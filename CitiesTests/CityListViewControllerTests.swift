//
//  CityListViewControllerTests.swift
//  CitiesTests
//
//  Created by Cửu Long Hoàng on 24/09/2022.
//

import XCTest
import RxSwift
@testable import Cities

class MockCityService: CityService {
    var successResult: Bool
    init(successResult: Bool = true) {
        self.successResult = successResult
    }
    
    func getCityList() -> Observable<CitiesResponse> {
        if successResult {
            return Observable.just(DataMockup.cities)
        } else {
            return Observable.error(NSError(domain: "city-service-path", code: 404, userInfo: ["message": "URL not found"]))
        }
    }
}

class CityListViewControllerTests: XCTestCase {
    
    var window: UIWindow!
    var sut: CityListViewController!
    var disposeBag: DisposeBag!
    
    func test_init_vc() {
        makeSUT()
        XCTAssertEqual(sut.navigationItem.title, "City")
    }
    
    func test_numberOfRows_tableView_equal_view_model_city_list_count() {
        makeSUT()
        
        XCTAssertNotNil(sut.viewModel)
        let cities = CityListSpy(sut.viewModel!.list)
        XCTAssertNotNil(cities)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), cities.citiesResponse.count)
    }
    
    func test_error_from_service() {
        makeSUT(successResult: false)
        
        XCTAssertNil(sut.viewModel)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_search_by_prefix() {
        makeSUT()
        XCTAssertNotNil(sut.viewModel)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), DataMockup.cities.count)
        sut.viewModel?.searchBy(prefix: "alb")
        let cities = CityListSpy(sut.viewModel!.list)
        XCTAssertNotNil(cities)
        XCTAssertEqual(cities.citiesResponse.count, 1)
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_city_cell_data() {
        makeSUT()
        XCTAssertNotNil(sut.viewModel)
        let cities = CityListSpy(sut.viewModel!.list)
        XCTAssertNotNil(cities)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), cities.citiesResponse.count)
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CityTableViewCell
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell!.titleLabel.text)
        XCTAssertNotNil(cell!.subTitleLabel.text)
        
        let titleText = cell!.titleLabel.text!
        XCTAssertTrue(titleText.contains(cities.citiesResponse.first!.name))
        XCTAssertTrue(titleText.contains(cities.citiesResponse.first!.country))
        
        let subTitleText = cell!.subTitleLabel.text!
        XCTAssertTrue(subTitleText.contains("\(cities.citiesResponse.first!.coord.lat)"))
        XCTAssertTrue(subTitleText.contains("\(cities.citiesResponse.first!.coord.lon)"))
    }
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        sut = nil
        window = nil
        super.tearDown()
    }
    
    private func makeSUT(successResult: Bool = true) {
        sut = CityListViewController(service: MockCityService(successResult: successResult)) { _ in
        }
        loadView()
    }
    
    private func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
}
