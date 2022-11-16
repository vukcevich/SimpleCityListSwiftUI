//
//  NetworkManager.swift
//  SimpleCityListSwiftUI
//
//  Created by MARIJAN VUKCEVICH on 11/16/22.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError>
}

extension URLSession: NetworkManagerProtocol {

    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return dataTaskPublisher(for: request)
            .map {
                //For Debug only:
                let dataString = $0.data.prettyjsonString
                print("Json-String:", dataString!)
                return $0.data
            }
            .eraseToAnyPublisher()
    }
}
