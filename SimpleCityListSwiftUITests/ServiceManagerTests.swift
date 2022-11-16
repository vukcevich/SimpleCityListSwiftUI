//
//  ServiceManagerTests.swift
//  SimpleCityListSwiftUITests
//
//  Created by MARIJAN VUKCEVICH on 11/16/22.
//

@testable import SimpleCityListSwiftUI
import Combine
import XCTest

final class ServiceManagerTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    
    func testWhenRequestSucceedsPublishesDecodedMenuItems() throws {
        let json = """
    [
     {
       "region" : "EU",
       "capital" : "Mariehamn",
       "code" : "AX",
       "flag" : "",
       "language" : {
         "name" : "Swedish",
         "code" : "sv"
       },
       "currency" : {
         "name" : "Euro",
         "symbol" : "€",
         "code" : "EUR"
       },
       "name" : "Åland Islands"
     }
    ]
    """
        let data = try XCTUnwrap(json.data(using: .utf8))
        let cityFetcher = ServiceManager(webService: NetworkManagerMock(returning: .success(data)))
        
        let expectation = XCTestExpectation(description: "Publishes decoded [MenuItem]")
        
        cityFetcher.fetchCountry()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { items in
                    XCTAssertEqual(items.count, 1)
                    XCTAssertEqual(items.first?.name, "Åland Islands")
                    XCTAssertEqual(items.first?.capital, "Mariehamn")
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenRequestFailsPublishesReceivedError() {
        let expectedError = URLError(.badServerResponse)
        let cityFetcher = ServiceManager(webService: NetworkManagerMock(returning: .failure(expectedError)))
        
        let expectation = XCTestExpectation(description: "Publishes received URLError")
        
        cityFetcher.fetchCountry()
            .sink(
                receiveCompletion: { completion in
                    guard case .failure(let error) = completion else { return }
                    XCTAssertEqual(error as? URLError, expectedError)
                    expectation.fulfill()
                },
                receiveValue: { items in
                    XCTFail("Expected to fail, succeeded with \(items)")
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

}
