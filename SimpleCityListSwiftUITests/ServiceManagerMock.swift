//
//  ServiceManagerMock.swift
//  SimpleCityListSwiftUITests
//
//  Created by MARIJAN VUKCEVICH on 11/16/22.
//

@testable import SimpleCityListSwiftUI
import Foundation
import Combine

class ServiceManagerMock: WebServiceProtocol {
    
    let result: Result<CountryModel, Error>

    init(returning result: Result<CountryModel, Error>) {
        self.result = result
    }

    func fetchCountry() -> AnyPublisher<CountryModel, Error> {
        return result.publisher
            // Use a delay to simulate the real world async behavior
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
