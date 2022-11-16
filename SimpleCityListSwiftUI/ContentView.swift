//
//  ContentView.swift
//  SimpleCityListSwiftUI
//
//  Created by MARIJAN VUKCEVICH on 11/16/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("City List")
        }
        .padding()
        CityListView(viewModel: ViewModel(countryFetch: ServiceManager()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
