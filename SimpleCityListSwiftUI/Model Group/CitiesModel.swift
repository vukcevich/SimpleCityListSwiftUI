//
//  CountryModel.swift
//  SimpleCityListSwiftUI
//
//  Created by MARIJAN VUKCEVICH on 11/16/22.
//

import Foundation

struct CountryInfo: Codable, Hashable {
   
    let capital, code: String?
    let currency: Currency?
    let flag: String?
    let language: Language?
    let name, region: String?
    
    static func ==(lhs: CountryInfo, rhs: CountryInfo) -> Bool {
        return lhs.name == rhs.name &&
        lhs.capital == rhs.capital &&
        lhs.code == rhs.code &&
        lhs.currency == rhs.currency &&
        lhs.flag == rhs.flag &&
        lhs.language == rhs.language &&
        lhs.region == rhs.region
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(capital)
    }
}

// MARK: - Currency
struct Currency: Codable, Equatable {
    let code, name, symbol: String?
}

// MARK: - Language
struct Language: Codable, Equatable {
    let code, name: String?
}

typealias CountryModel = [CountryInfo]
