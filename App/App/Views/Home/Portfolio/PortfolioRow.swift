//
//  PortfolioRow.swift
//  App
//
//  Created by Kai Wang on 4/27/22.
//

import SwiftUI

struct PortfolioRow: View {
    var portfolioItem: TickerRowItem
    var changeInPrice: Double
    var changeInPricePercentage: Double
    var trend: Trend
    
    init(portfolioItem: TickerRowItem) {
        self.portfolioItem = portfolioItem
        self.changeInPrice = changeInPriceFromTotal(latest: portfolioItem.price.current, avgCost:portfolioItem.portfolioLocalStorageItem.avgCost, numOfShares: portfolioItem.portfolioLocalStorageItem.numOfShares)
        self.changeInPricePercentage = changeInPriceFromTotalPercentage(latest: portfolioItem.price.current, avgCost:portfolioItem.portfolioLocalStorageItem.avgCost, numOfShares: portfolioItem.portfolioLocalStorageItem.numOfShares)
        if self.changeInPricePercentage > 0 {
            self.trend = Trend(color: Color.green, img:Image(systemName: "arrow.up.forward"))
        } else if self.changeInPricePercentage < 0 {
            self.trend = Trend(color:Color.red, img:Image(systemName: "arrow.down.forward"))
        } else {
            self.trend = Trend(color:Color.gray, img:Image(systemName: "minus"))
        }
    }
                                                                   
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
                Text("$\(marketValue(latest: portfolioItem.price.current, numOfShares: portfolioItem.portfolioLocalStorageItem.numOfShares), specifier: "%.2f")")
                    .font(.headline)
                    .fontWeight(.semibold)
                HStack {
                    self.trend.img

                    Text("$\(self.changeInPrice, specifier: "%.2f") (\(self.changeInPricePercentage, specifier: "%.2f")%)")
                }
                .foregroundColor(self.trend.color)
            }
        }
    }
}

//struct PortfolioRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PortfolioRow(portfolioItem: TickerRowItem(portfolioLocalStorageItem: TickerLocalStorageItem(ticker: "TSLA", numOfShares: 2, companyName: "TESLA INC"), price: TickerLastPrice(current: 870.76, change: -6.75, percentageChange: -0.7692, high: 934.3999, low: 870, open: 902.25, previousClose: 877.51, timeStamp: 1651262404)))
//    }
//}
