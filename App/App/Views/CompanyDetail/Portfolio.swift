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
                .font(.title)
                .padding(.bottom, 5)
            HStack(alignment: .center) {
                VStack(alignment: .leading){
                    
                    if let row = portfolioLocalStorageList.firstIndex(where: {$0.ticker == self.ticker}){
                        
                        Text("**Shares Owned**: \(portfolioLocalStorageList[row].numOfShares)").padding(.bottom, 3)
                        Text("**Avg. Cost / Share:** $\(portfolioLocalStorageList[row].avgCost, specifier: "%.2f")").padding(.bottom, 3)
                        Text("**Total Cost**: $\(portfolioLocalStorageList[row].avgCost * Double(portfolioLocalStorageList[row].numOfShares), specifier: "%.2f")").padding(.bottom, 3)
                        Text("**Change**: $\((self.companyDetailVM.price!.current - portfolioLocalStorageList[row].avgCost) * Double(portfolioLocalStorageList[row].numOfShares), specifier: "%.2f")").padding(.bottom, 3)
                        Text("**Market Value:** $\(self.companyDetailVM.price!.current * Double(portfolioLocalStorageList[row].numOfShares), specifier: "%.2f")").padding(.bottom, 3)
                        
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
        }
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        Portfolio(ticker: "TSLA")
    }
}
