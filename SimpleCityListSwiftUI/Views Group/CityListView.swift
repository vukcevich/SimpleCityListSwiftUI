//
//  CityListView.swift
//  SimpleCityListSwiftUI
//
//  Created by MARIJAN VUKCEVICH on 11/16/22.
//

import SwiftUI

struct CityListView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        switch viewModel.countryInfos {
        case .success(let countryInfos):
            List {
                ForEach(countryInfos.dropFirst(), id: \.self) { country in
                    VStack (alignment: .leading) {
                        HStack (spacing: 20) {
                            Text((country.name ?? "") + ", " + (country.region ?? ""))
                                .font(.headline)
                            Spacer()
                            Text(country.code ?? "")
                                .font(.caption)
                                .frame(alignment: .trailing)
                        }
                        .padding(.bottom, 10)
                        Text(country.capital ?? "")
                            .font(.subheadline)
                            .padding(0)
                    }
                    .frame(alignment: .leading)
                }
            }
        case .failure(let error):
            Text("An error occurred:")
            Text(error.localizedDescription).italic()
        }
    }
}

