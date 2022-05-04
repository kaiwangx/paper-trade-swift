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
    @AppStorage("favorites") var favoritesLocalStorageList: [TickerLocalStorageItem] = []
    let dateFormatter = DateFormatter()
    let date = Date()

    var body: some View {
        
        NavigationView {
            if searchBar.text.isEmpty {
                List {
                    Today()
                    PortfolioList()
                    FavoritesList()
                    Footer()
                }
                .navigationTitle("Stocks")
                .add(searchBar)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            } else {
                AutocompleteList(tickerAutocompleteList: tickerAutocompleteVM.tickerAutocompleteList)
                    .onReceive(searchBar.$text, perform: { ticker in
                        if ticker != "" {
                            tickerAutocompleteVM.fetchTickerAutocompleteList(ticker)
                        } else {
                            tickerAutocompleteVM.reset()
                        }
                    })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
