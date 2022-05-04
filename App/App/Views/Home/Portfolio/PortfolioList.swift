//
//  PortfolioList.swift
//  App
//
//  Created by Kai Wang on 4/27/22.
//

import SwiftUI

struct PortfolioList: View {
    @AppStorage("portfolio") var portfolioLocalStorageList: [TickerLocalStorageItem] = []
    @AppStorage("balance") var balance = 25000.00
    @ObservedObject var tickerAutoUpdateVM: TickerAutoUpdateListVM = TickerAutoUpdateListVM()
    var testList = ["1", "2", "3"]
    
    init() {
        self.tickerAutoUpdateVM.set(self.portfolioLocalStorageList)
    }
    
    
    var body: some View {
        Section {
            HStack {
                VStack(alignment: .leading) {
                    Text("Net Worth")
                    Text("\(self.tickerAutoUpdateVM.netWorth + self.balance, specifier: "%.2f")")
                        .fontWeight(.bold)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Cash Balance")
                    Text("$\(self.balance, specifier: "%.2f")")
                        .fontWeight(.bold)
                }
            }
            .font(.title3)
            
            Button("Reset") {
                self.balance = 25000.00
                self.portfolioLocalStorageList.removeAll()
            }
            
            ForEach(tickerAutoUpdateVM.tickerList) { item in
                NavigationLink {
                    LazyView(CompanyDetail(ticker: item.portfolioLocalStorageItem.ticker))
                } label: {
                    PortfolioRow(portfolioItem: item)
                }
            }
            .onChange(of: portfolioLocalStorageList) { newPortfolioLocalStorageList in
                self.tickerAutoUpdateVM.set(self.portfolioLocalStorageList)
            }
        } header: {
            Text("PORTFOLIO")
        }
    }
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
