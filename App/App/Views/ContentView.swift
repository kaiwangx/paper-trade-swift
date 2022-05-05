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
            Group {
                if searchBar.text.isEmpty {
                    List {
                        Today()
                        PortfolioList()
                        FavoritesList()
                        Footer()
                    }
                    
                    .add(searchBar)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                    }
                    .onAppear {
                        tickerAutocompleteVM.reset()
                    }
                } else {
                    AutocompleteList(tickerAutocompleteList: tickerAutocompleteVM.tickerAutocompleteList)
                        .onReceive(searchBar.$text.debounce(for: .seconds(1), scheduler: DispatchQueue.main)) {
                            if $0 != "" {
                                tickerAutocompleteVM.reset()
                                tickerAutocompleteVM.fetchTickerAutocompleteList($0)
                            }
                        }
                }
            }
            .navigationTitle("Stocks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
