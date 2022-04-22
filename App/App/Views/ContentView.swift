//
//  ContentView.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @ObservedObject var tickerAutocompleteVM: TickerAutocompleteVM = TickerAutocompleteVM()
    let dateFormatter = DateFormatter()
    var calendar = Calendar.current
    let date = Date()

    var body: some View {
        
        NavigationView {
            if searchBar.text.isEmpty {
                VStack {
                    Text(Date(), style: .date)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                }
                .navigationTitle("Stocks")
                .add(searchBar)
            } else {
                AutocompleteList(tickerAutocompleteList: tickerAutocompleteVM.tickerAutocompleteList)
                .onChange(of: searchBar.text) {
                    tickerAutocompleteVM.fetchTickerAutocompleteList($0)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
