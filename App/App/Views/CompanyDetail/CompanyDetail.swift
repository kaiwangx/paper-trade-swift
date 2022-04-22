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
    
    init(ticker: String) {
        self.ticker = ticker
        companyDetailVM = CompanyDetailVM(ticker)
    }
    
    var body: some View {

        if self.companyDetailVM.isLoading {
            Spinner()
        } else {
            ScrollView{
                VStack{
                    Title()
                    
                    Price()
                    
                    PriceCharts(ticker: self.ticker)
                        .frame(height: 450)
                
                    Portfolio(ticker: self.ticker)
                        .padding(.top)
                        .font(.callout)
                    
                    Stats(price: self.companyDetailVM.price!)
                        .padding(.top)
                        .font(.callout)
                    
                    About()
                        .padding(.top)
                        .font(.callout)

                    Insights()
                        .padding(.top)
                    
                    CompanyNews()
                    
                    Spacer()
                }
            }
            .padding(.horizontal).navigationTitle(companyDetailVM.description!.ticker)
            .environmentObject(self.companyDetailVM)
        }
    }
        
}

struct CompanyDetail_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetail(ticker: "TSLA")
    }
}
