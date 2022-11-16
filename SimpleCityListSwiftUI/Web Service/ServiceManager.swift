//
//  ServiceManager.swift
//  SimpleCityListSwiftUI
//
//  Created by MARIJAN VUKCEVICH on 11/16/22.
//

import Foundation
import Combine

enum BaseUrl: String {
    case baseUrl = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
}

protocol WebServiceProtocol {

    func fetchCountry() -> AnyPublisher<CountryModel, Error>
}

class ServiceManager: WebServiceProtocol {
    
    let webService: NetworkManagerProtocol
    
    init(webService: NetworkManagerProtocol = URLSession.shared) {
        self.webService = webService
    }
    
    func fetchCountry() -> AnyPublisher<CountryModel, Error> {
        return webService.load(URLRequest(url: URL(string: BaseUrl.baseUrl.rawValue)!))
            .decode(type: CountryModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
