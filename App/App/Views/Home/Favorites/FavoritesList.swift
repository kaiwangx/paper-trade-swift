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
    @ObservedObject var tickerAutoUpdateVM: TickerAutoUpdateDictVM = TickerAutoUpdateDictVM()
    
    init() {
        self.tickerAutoUpdateVM.set(self.favoritesLocalStorageList)
    }

    var body: some View {
        
        
        Section {
// for test purpose
//            VStack {
//                Button("Check local storage") {
//                    print(self.favoritesLocalStorageList)
//                }
//            }
//
//            VStack {
//                Button("Reset") {
//                    favoritesLocalStorageList.removeAll()
//                }
//            }

            if (tickerAutoUpdateVM.tickerDict.count == 0) {
//                Text("Your favorites list i2s empty")
            } else {
                ForEach(favoritesLocalStorageList) { item in
                    NavigationLink {
                        LazyView(CompanyDetail(ticker: item.ticker))
                    } label: {
                        FavoritesRow(favoritesItem: self.tickerAutoUpdateVM.tickerDict[item.ticker]!)
                    }
                }
                .onDelete(perform: removeRows)
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
    
    func removeRows(at offsets: IndexSet) {
        favoritesLocalStorageList.remove(atOffsets: offsets)
    }
}



struct FavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesList()
    }
}
