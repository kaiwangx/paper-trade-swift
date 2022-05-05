//
//  TradeSheet.swift
//  App
//
//  Created by Kai Wang on 4/22/22.
//

import SwiftUI
import Combine

struct TradeSheet: View {
    @EnvironmentObject var companyDetailVM: CompanyDetailVM
    @Environment(\.dismiss) private var dismiss
    @State private var numOfShare = ""
    @State private var complete = false
    @State private var type = ""
    @AppStorage("portfolio") var portfolioLocalStorageList: [TickerLocalStorageItem] = []
    @AppStorage("balance") var balance = 25000.00
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    var body: some View {
        
        if self.complete {
            TradeCompleteSheet(companyName: companyDetailVM.description!.ticker, numOfShares: self.numOfShare, type: self.type)
        } else {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                    
                }
                .padding(.vertical)
                
                HStack {
                    Spacer()
                    Text("Trade \(companyDetailVM.description!.name) shares")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                }
                
                Spacer()
                
                
                HStack(alignment: .bottom) {
                    TextField("0", text: $numOfShare)
                        .keyboardType(.numberPad)
                        .onReceive(Just(numOfShare)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.numOfShare = filtered
                            }
                    }
                        .font(.system(size: 80.0))
                    
                    Spacer()
                    Text("Shares")
                        .font(.largeTitle)
                        .padding(.bottom)
                }
                
                HStack {
                    Spacer()
                    Text("x $\(self.companyDetailVM.price!.current, specifier: "%.2f")/share = $\((self.numOfShare == "" ? Double(0) : self.companyDetailVM.price!.current * Double(self.numOfShare)!), specifier: "%.2f")")
                        .font(.callout)
                }
                
                
                Spacer()
                
                VStack {
                    HStack {
                        Spacer()
                        Text("$\(self.balance, specifier: "%.2f") available to buy AAPL")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    
                    HStack {
                        Button {
                            buyStock()
                        } label: {
                            Text("Buy")
                                .font(.callout)
                                .padding(.horizontal, 65)
                                .padding(.vertical, 12)
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(30)
                        }
                        .padding(.trailing, 10)

                        Button {
                            sellStock()
                        } label: {
                            Text("Sell")
                                .font(.callout)
                                .padding(.horizontal, 65)
                                .padding(.vertical, 12)
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(30)
                        }
                    }
                    .padding(.vertical, 20)
                }
            }
            .padding(.horizontal, 20.0)
            .toast(isPresented: self.$showToast) {
                HStack {
                    Text(self.toastMessage)
                        .foregroundColor(.white)
                } //HStack
            } //toast
            .onChange(of: toastMessage) { message in
                self.showToast.toggle()
            }
        }
    }
    
    
    
    func buyStock() {
        if self.numOfShare == "" {
            self.toastMessage = "Please enter a valid amount"
        } else if Int(self.numOfShare) == 0 {
            self.toastMessage = "Cannot sell non-positive shares"
        } else if Double(self.numOfShare)! * self.companyDetailVM.price!.current > self.balance{
            self.toastMessage = "Not enough money to buy"
        } else {
            let totalCost = Double(self.numOfShare)! * self.companyDetailVM.price!.current
            if let row = portfolioLocalStorageList.firstIndex(where: {$0.ticker == self.companyDetailVM.description!.ticker}) {
                portfolioLocalStorageList[row].avgCost = (portfolioLocalStorageList[row].avgCost * Double(portfolioLocalStorageList[row].numOfShares) + totalCost) / (Double(portfolioLocalStorageList[row].numOfShares) + Double(self.numOfShare)!)
                portfolioLocalStorageList[row].numOfShares += Int(self.numOfShare)!
            } else {
                portfolioLocalStorageList.append(TickerLocalStorageItem(ticker: self.companyDetailVM.description!.ticker, numOfShares: Int(self.numOfShare)!, companyName: self.companyDetailVM.description!.name, avgCost: self.companyDetailVM.price!.current))
            }
            balance -= totalCost
            self.complete = true
            self.type = "bought"
        }
    }
    
    
    func sellStock() {
        if self.numOfShare == "" {
            self.toastMessage = "Please enter a valid amount"
            self.showToast.toggle()
        } else if Int(self.numOfShare) == 0 {
            self.toastMessage = "Cannot buy non-positive shares"
        } else {
            var status = false
            if let row = portfolioLocalStorageList.firstIndex(where: {$0.ticker == self.companyDetailVM.description!.ticker}) {
                if portfolioLocalStorageList[row].numOfShares > Int(self.numOfShare)! {
                    portfolioLocalStorageList[row].numOfShares -= Int(self.numOfShare)!
                    status = true
                } else if portfolioLocalStorageList[row].numOfShares == Int(self.numOfShare)! {
                    portfolioLocalStorageList = portfolioLocalStorageList.filter { $0.ticker != self.companyDetailVM.description!.ticker }
                    status = true
                }
            }
            
            if status {
                self.type = "sold"
                self.complete = true
                self.balance += Double(self.numOfShare)! * self.companyDetailVM.price!.current
            } else {
                self.toastMessage = "Not enough shares to sell"
            }
        }
    }
}
