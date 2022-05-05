//
//  Portfolio.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI

struct Portfolio: View {
    @State var ticker: String
    @State private var isShowingSheet = false
    @AppStorage("portfolio") var portfolioLocalStorageList: [TickerLocalStorageItem] = []
    @EnvironmentObject var companyDetailVM: CompanyDetailVM
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Portfolio")
                .font(.system(size: 23.0))
//                .fontWeight(.semibold)
                .padding(.bottom, 5)
            HStack(alignment: .center) {
                VStack(alignment: .leading){
                    
                    if let row = portfolioLocalStorageList.firstIndex(where: {$0.ticker == self.ticker}){
                        let sharesOwned = portfolioLocalStorageList[row].numOfShares
                        let avgCost = portfolioLocalStorageList[row].avgCost
                        let totalCost = portfolioLocalStorageList[row].avgCost * Double(portfolioLocalStorageList[row].numOfShares)
                        let change = changeInPriceFromTotal(latest: self.companyDetailVM.price!.current, avgCost: portfolioLocalStorageList[row].avgCost, numOfShares: portfolioLocalStorageList[row].numOfShares)
                        let marketValue = marketValue(latest: self.companyDetailVM.price!.current, numOfShares: portfolioLocalStorageList[row].numOfShares)
                        Text("**Shares Owned**: \(sharesOwned)").padding(.bottom, 3)
                        Text("**Avg. Cost / Share:** $\(avgCost, specifier: "%.2f")").padding(.bottom, 3)
                        Text("**Total Cost**: $\(totalCost, specifier: "%.2f")").padding(.bottom, 3)
                        Group {
                            Text("**Change**: ") + Text("$\(change, specifier: "%.2f")").foregroundColor(change == 0 ? .secondary : (change > 0 ? .green : .red))
                        }.padding(.bottom, 3)
                        Group {
                            Text("**Market Value:** ") + Text("$\(marketValue, specifier: "%.2f")").foregroundColor(change == 0 ? .secondary : (change > 0 ? .green : .red))
                        }.padding(.bottom, 3)
                        
                    } else {
                        Text("Your have 0 shares of \(self.ticker).")
                        Text("Start trading!")
                    }
                }
                Spacer()
                VStack {
                    Button {
                        self.isShowingSheet.toggle()
                    } label: {
                        Text("Trade")
                            .font(.callout)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 12)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(30)
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            TradeSheet()
                .font(.callout)
        }
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        Portfolio(ticker: "TSLA")
    }
}
