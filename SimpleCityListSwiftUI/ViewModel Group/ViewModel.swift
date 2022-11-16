//
//  ViewModel.swift
//  SimpleCityListSwiftUI
//
//  Created by MARIJAN VUKCEVICH on 11/16/22.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    @Published private(set) var countryInfos: Result<CountryModel, Error> = .success([])
    
    private var cancellables = Set<AnyCancellable>()
    
    init(countryFetch: WebServiceProtocol) {
        countryFetch.fetchCountry()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard case .failure(let error) = completion else { return }
                    self?.countryInfos = .failure(error)
                },
                receiveValue: { [weak self] value in
                    self?.countryInfos = .success(value)
                }
            )
            .store(in: &cancellables)
    }
}
