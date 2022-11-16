//
//  NetworkManagerMock.swift
//  SimpleCityListSwiftUITests
//
//  Created by MARIJAN VUKCEVICH on 11/16/22.
//

@testable import SimpleCityListSwiftUI
import Foundation
import Combine

class NetworkManagerMock: NetworkManagerProtocol {
    
    private let result: Result<Data, URLError>

    init(returning result: Result<Data, URLError>) {
        self.result = result
    }

    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return result.publisher
            // Use a delay to simulate the real world async behavior
            .delay(for: 0.01, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
