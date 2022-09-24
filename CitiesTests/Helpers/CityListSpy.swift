//
//  CityListSpy.swift
//  CitiesTests
//
//  Created by Cửu Long Hoàng on 24/09/2022.
//

import RxSwift
@testable import Cities

class CityListSpy {
    private(set) var citiesResponse: CitiesResponse = CitiesResponse()
    private(set) var disposable: Disposable?
    
    init(_ behavior: BehaviorSubject<CitiesResponse>) {
        disposable = behavior.subscribe(onNext: { cities in
            self.citiesResponse = cities
        })
    }
}
