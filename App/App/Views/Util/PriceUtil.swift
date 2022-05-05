//
//  PriceChange.swift
//  App
//
//  Created by Kai Wang on 5/3/22.
//

import Foundation

func changeInPriceFromTotal(latest: Double, avgCost: Double, numOfShares: Int) -> Double {
    return (latest - avgCost) * Double(numOfShares)
}

func changeInPriceFromTotalPercentage(latest: Double, avgCost: Double, numOfShares: Int) -> Double {
    let changeInTotal = changeInPriceFromTotal(latest: latest, avgCost: avgCost, numOfShares: numOfShares)
    return changeInTotal / (avgCost * Double(numOfShares)) * 100
}

func marketValue(latest: Double, numOfShares: Int) -> Double {
    return Double(numOfShares) * latest
}
