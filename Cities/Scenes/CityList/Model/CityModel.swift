//
//  CityModel.swift
//  Cities
//
//  Created by Cửu Long Hoàng on 14/09/2022.
//

import Foundation

typealias CitiesResponse = [CityModel]
struct CityModel: Codable {
    let country: String
    let name: String
    let id: Int
    let coord: CityCoordinateModel
    
    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
    
}

extension CityModel: Equatable {
    static func == (lhs: CityModel, rhs: CityModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension CityModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension CityModel: Comparable {
    static func < (lhs: CityModel, rhs: CityModel) -> Bool {
        if (lhs.name == rhs.name) {
            return lhs.country < rhs.country
        }
        return lhs.name < lhs.country
    }
    
    static func > (lhs: CityModel, rhs: CityModel ) -> Bool {
        if (lhs.name == rhs.name) {
            return lhs.country > rhs.country
        }
        return lhs.name > lhs.country
    }
    
    static func != (lhs: CityModel, rhs: CityModel) -> Bool {
        return lhs.id != rhs.id
    }
}

struct CityCoordinateModel: Codable {
    let lon: Double
    let lat: Double
}


