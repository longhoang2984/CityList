//
//  CityService.swift
//  Cities
//
//  Created by Cửu Long Hoàng on 14/09/2022.
//

import Foundation
import RxSwift

protocol CityService {
    func getCityList() -> Observable<CitiesResponse>
}

class GithubService: CityService {
    let cityURLPath: String = "https://raw.githubusercontent.com/SiriusiOS/ios-assignment/main/cities.json"
    private let bag: DisposeBag = DisposeBag()
    
    func getCityList() -> Observable<CitiesResponse> {
        guard let url: URL = URL(string: self.cityURLPath) else {
            return Observable.error(NSError(domain: self.cityURLPath, code: 404, userInfo: ["message": "URL not found"]))
        }

        let resource = Resource<CitiesResponse>(url: url)
        return URLRequest.load(resource: resource)
    }
    
}
