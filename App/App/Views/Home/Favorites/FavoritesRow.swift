//
//  FavoritesRow.swift
//  App
//
//  Created by Kai Wang on 5/1/22.
//

import SwiftUI

struct FavoritesRow: View {
    var favoritesItem: TickerRowItem
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(favoritesItem.portfolioLocalStorageItem.ticker)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("\(favoritesItem.portfolioLocalStorageItem.companyName)")
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("$\(self.favoritesItem.price.current, specifier: "%.2f")")
                    .font(.headline)
                    .fontWeight(.semibold)
                HStack {
                    self.favoritesItem.price.trend.img
                    Text("$\(self.favoritesItem.price.change, specifier: "%.2f") (\(self.favoritesItem.price.percentageChange, specifier: "%.2f")%)")
                }
                .foregroundColor(self.favoritesItem.price.trend.color)
            }
        }
    }
}
