//
//  PortfolioLocalStorageItem.swift
//  App
//
//  Created by Kai Wang on 5/1/22.
//

import Foundation

struct TickerLocalStorageItem: Identifiable, Codable, Equatable {
    var ticker: String
    var numOfShares: Int
    var id: String {ticker}
    var companyName: String
    var avgCost: Double
}
