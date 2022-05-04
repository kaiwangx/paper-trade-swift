//
//  FavoritesList.swift
//  App
//
//  Created by Kai Wang on 5/1/22.
//

import SwiftUI

struct FavoritesList: View {
//    @Environment(\.favorites) private var favoritesLocalStorageList: [TickerLocalStorageItem]
    @AppStorage("favorites") var favoritesLocalStorageList: [TickerLocalStorageItem] = []
    @ObservedObject var tickerAutoUpdateVM: TickerAutoUpdateListVM = TickerAutoUpdateListVM()
    
    init() {
        self.tickerAutoUpdateVM.set(self.favoritesLocalStorageList)
    }

    var body: some View {
        
        
        Section {
            VStack {
                Button("Check local storage") {
                    print(self.favoritesLocalStorageList)
                }
            }
            
            VStack {
                Button("Reset") {
                    favoritesLocalStorageList.removeAll()
                }
            }

            if (tickerAutoUpdateVM.tickerList.count == 0) {
//                Text("Your favorites list is empty")
            } else {
                ForEach(tickerAutoUpdateVM.tickerList) { item in
                    NavigationLink {
                        LazyView(CompanyDetail(ticker: item.portfolioLocalStorageItem.ticker))
                    } label: {
                        FavoritesRow(favoritesItem: item)
                    }
                }
                .onMove(perform: move)
                .onChange(of: favoritesLocalStorageList) { newFavoritesLocalStorageList in
                    self.tickerAutoUpdateVM.set(self.favoritesLocalStorageList)
                }
            }
        } header: {
            Text("FAVORITES")
        }
    }
    func move(from source: IndexSet, to destination: Int) {
        favoritesLocalStorageList.move(fromOffsets: source, toOffset: destination)
    }
}



struct FavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesList()
    }
}
