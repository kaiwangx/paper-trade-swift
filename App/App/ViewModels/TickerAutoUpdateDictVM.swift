//
//  PortfolioListVM.swift
//  App
//
//  Created by Kai Wang on 5/1/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class TickerAutoUpdateDictVM: ObservableObject {
    @Published var tickerDict: [String: TickerRowItem]
    @Published var netWorth: Double = 0.0
    weak var timer: Timer?
    var completedFetches = 0
    var incompleteDict: [String: TickerRowItem]
    var tickerLocalStorageList: [TickerLocalStorageItem] = []
    
    init() {
        self.tickerDict = [String: TickerRowItem]()
        self.incompleteDict = [String: TickerRowItem]()
        self.netWorth = 0.0
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: true) { [weak self] _ in
            if self!.tickerLocalStorageList.count > 0 {
                self!.update(self!.tickerLocalStorageList)
            }
        }
    }
    
    
    func set(_ tickerLocalStorageList: [TickerLocalStorageItem]) {
        self.tickerLocalStorageList = tickerLocalStorageList
        self.update(tickerLocalStorageList)
    }
    
    
    func update(_ tickerLocalStorageList: [TickerLocalStorageItem]) {
        
        if tickerLocalStorageList.count == 0 {
            self.tickerDict = [String: TickerRowItem]()
            self.netWorth = 0
        } else {
            self.completedFetches = 0
            self.incompleteDict = [String: TickerRowItem]()
            tickerLocalStorageList.forEach{PortfolioLocalStorageItem in
                fetchCompanyPrice(PortfolioLocalStorageItem)
            }
        }
    }
    
    func fetchCompanyPrice(_ portfolioLocalStorageItem: TickerLocalStorageItem) {
        let ticker = portfolioLocalStorageItem.ticker
        AF.request("\(serverURL)/latest_price/\(ticker)").validate().responseDecodable(of: TickerLastPrice.self) { response in
            switch response.result {
            case let .success(data):
                self.incompleteDict[portfolioLocalStorageItem.ticker] = TickerRowItem(portfolioLocalStorageItem: portfolioLocalStorageItem, price: data)
                
                self.completedFetches += 1
                
                if self.incompleteDict.count == self.tickerLocalStorageList.count {
                    self.tickerDict = self.incompleteDict
                    self.netWorth = self.tickerDict.values.map({$0.price.current * Double($0.portfolioLocalStorageItem.numOfShares)}).reduce(0, +)
                }
                
            case let .failure(error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }

    // if appropriate, make sure to stop your timer in `deinit`
    deinit {
        stopTimer()
    }
}
