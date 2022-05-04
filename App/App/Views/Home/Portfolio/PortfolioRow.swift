//
//  PortfolioRow.swift
//  App
//
//  Created by Kai Wang on 4/27/22.
//

import SwiftUI

struct PortfolioRow: View {
    var portfolioItem: TickerRowItem
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(portfolioItem.portfolioLocalStorageItem.ticker)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("\(portfolioItem.portfolioLocalStorageItem.numOfShares) shares")
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("$\(self.portfolioItem.price.current, specifier: "%.2f")")
                    .font(.headline)
                    .fontWeight(.semibold)
                HStack {
                    self.portfolioItem.price.trend.img
                    Text("$\(self.portfolioItem.price.change, specifier: "%.2f") (\(self.portfolioItem.price.percentageChange, specifier: "%.2f")%)")
                }
                .foregroundColor(self.portfolioItem.price.trend.color)
            }
        }
    }
}

//struct PortfolioRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PortfolioRow(portfolioItem: TickerRowItem(portfolioLocalStorageItem: TickerLocalStorageItem(ticker: "TSLA", numOfShares: 2, companyName: "TESLA INC"), price: TickerLastPrice(current: 870.76, change: -6.75, percentageChange: -0.7692, high: 934.3999, low: 870, open: 902.25, previousClose: 877.51, timeStamp: 1651262404)))
//    }
//}
