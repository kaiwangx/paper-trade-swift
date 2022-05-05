//
//  CompanyDetail.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI

struct CompanyDetail: View {
    var ticker: String
    @ObservedObject var companyDetailVM: CompanyDetailVM
    @AppStorage("favorites") var favoritesLocalStorageList: [TickerLocalStorageItem] = []
    
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    
    init(ticker: String) {
        self.ticker = ticker
        companyDetailVM = CompanyDetailVM(ticker)
    }
    
    var body: some View {

        if self.companyDetailVM.numCompletedFetched < self.companyDetailVM.numFetches {
            Spinner()
        } else {
            ScrollView{
                VStack{
                    Title()
                        .padding(.horizontal)
                    
                    Price()
                        .padding(.horizontal)
                    
                    PriceCharts(ticker: self.ticker)
                        .frame(height: 440)
                
                    Portfolio(ticker: self.ticker)
                        .padding(.horizontal)
                        .padding(.top)
                        .font(.caption)
                    
                    Stats(price: self.companyDetailVM.price!)
                        .padding(.horizontal)
                        .padding(.top)
                        .font(.caption)
                    
                    About()
                        .padding(.horizontal)
                        .padding(.top)
                        .font(.caption)

                    Insights()
                        .padding(.horizontal)
                        .padding(.top)
                    
                    CompanyNews()
                        .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .toast(isPresented: self.$showToast) {
                HStack {
                    Text(self.toastMessage)
                        .foregroundColor(.white)
                } //HStack
            } //toast
            .onChange(of: toastMessage) { message in
                self.showToast.toggle()
            }
            .navigationTitle(companyDetailVM.description!.ticker)
            .environmentObject(self.companyDetailVM)
            .toolbar {
                ToolbarItemGroup(placement: .navigation) {
                    if favoritesLocalStorageList.contains(where: {$0.ticker == self.ticker}) {
                        Button {
                            favoritesLocalStorageList = favoritesLocalStorageList.filter { $0.ticker != self.ticker }
                            self.toastMessage = "Removing \(self.ticker) from Favorites"
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                    } else {
                        Button {
                            favoritesLocalStorageList.append(TickerLocalStorageItem(ticker: self.ticker, numOfShares: 0, companyName: companyDetailVM.description!.name, avgCost: 0.00))
                            self.toastMessage = "Adding \(self.ticker) to Favorites"
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
            }
        }
    }
        
}

struct CompanyDetail_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetail(ticker: "TSLA")
    }
}
