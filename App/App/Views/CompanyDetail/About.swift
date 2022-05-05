//
//  About.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI

struct About: View {
    @EnvironmentObject var companyDetailVM: CompanyDetailVM

    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("About")
                    .font(.system(size: 23.0))
                    .padding(.bottom, 5)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("**IPO Start Date**:")
                        .padding(.bottom, 3)
                    Text("**Industry**:")
                        .padding(.bottom, 3)
                    Text("**Webpage**:")
                        .padding(.bottom, 3)
                    Text("**Company Peers**:")
                }
                .padding(.trailing)
                VStack(alignment: .leading) {
                    Text(self.companyDetailVM.description!.ipo)
                        .padding(.bottom, 3)
                    Text(self.companyDetailVM.description!.finnhubIndustry)
                        .padding(.bottom, 3)
                    HStack{
                    Link(self.companyDetailVM.description!.weburl, destination: URL(string: self.companyDetailVM.description!.weburl)!)
                            .padding(.bottom, 3)
                            .lineLimit(1)
                    }
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(self.companyDetailVM.peers!, id: \.self) { peer in
                                NavigationLink {
                                    LazyView(CompanyDetail(ticker: peer))
                                } label: {
                                    Text("\(peer),")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}
