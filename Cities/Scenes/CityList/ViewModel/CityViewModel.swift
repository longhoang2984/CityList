//
//  CityViewModel.swift
//  Cities
//
//  Created by Cửu Long Hoàng on 14/09/2022.
//

import Foundation
import RxSwift

struct CityViewModel {
    var list: BehaviorSubject = BehaviorSubject(value: CitiesResponse())
    private let bag: DisposeBag = DisposeBag()
    let cityTrie = Trie()
    let countryTrie = Trie()
    private(set) var cities: CitiesResponse
    
    init(cities: CitiesResponse) {
        for city in cities {
            cityTrie.insert(key: city.name, city: city)
            countryTrie.insert(key: city.country, city: city)
        }
        self.cities = cityTrie.cities.sorted(by: { return $0.name < $1.name })
        emitList(list: self.cities)
    }
    
    private func sort(response: CitiesResponse) -> CitiesResponse  {
        for city in response {
            cityTrie.insert(key: city.name, city: city)
            countryTrie.insert(key: city.country, city: city)
        }
        return cityTrie.cities.sorted(by: { return $0.name < $1.name })
    }
    
    private func getCitiesByPrefixCountry(_ prefix: String, filteredList: CitiesResponse) {
        if prefix.count > Constant.maxCountryCodeLength {
            emitList(list: filteredList)
            return
        }
        var listCitiesFromCountryTrie = countryTrie.findCitiesWithPrefix(prefix, filteredCityList: filteredList)
        listCitiesFromCountryTrie += filteredList
        emitList(list: listCitiesFromCountryTrie.sorted(by: { return $0.name < $1.name }))
    }
    
    func searchBy(prefix: String) {
        let list = cityTrie.findCitiesWithPrefix(prefix)
        getCitiesByPrefixCountry(prefix, filteredList: list)
    }
    
    private func emitList(list: CitiesResponse) {
        self.list.on(.next(list))
    }
}
