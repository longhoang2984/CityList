//
//  CityService.swift
//  Cities
//
//  Created by Cửu Long Hoàng on 14/09/2022.
//

import Foundation
import RxSwift

class CityService {
    
    static let shared: CityService = CityService()
    static let cityURLPath: String = "https://raw.githubusercontent.com/SiriusiOS/ios-assignment/main/cities.json"
    private let bag: DisposeBag = DisposeBag()
    
    func getCityList() -> Observable<CitiesResponse> {
        guard let url: URL = URL(string: CityService.cityURLPath) else {
            return Observable.error(NSError(domain: CityService.cityURLPath, code: 404, userInfo: ["message": "URL not found"]))
        }

        let resource = Resource<CitiesResponse>(url: url)
        return URLRequest.load(resource: resource)
    }
    
}
