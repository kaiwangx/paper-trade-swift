//
//  PortfolioItem.swift
//  App
//
//  Created by Kai Wang on 4/27/22.
//

import Foundation

struct TickerRowItem: Identifiable {
    var portfolioLocalStorageItem: TickerLocalStorageItem
    var id: String {portfolioLocalStorageItem.ticker}
    var price: TickerLastPrice
}
