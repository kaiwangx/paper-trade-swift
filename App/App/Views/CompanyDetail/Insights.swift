//
//  Insights.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI

struct Insights: View {
    @EnvironmentObject var companyDetailVM: CompanyDetailVM
    var body: some View {
        VStack {
            HStack {
                Text("Insights")
                    .font(.system(size: 23.0))
                    .padding(.bottom, 5)
                Spacer()
            }
            
            HStack {
                Spacer()
                Text("Social Sentiments")
                    .font(.title2)
                    .padding(.bottom, 3)
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Divider()
                    Text("**\(self.companyDetailVM.description!.name)**")
                    Divider()
                    Text("**Total   Mentions**")
                    Divider()
                    Text("**Positive Mentions**")
                    Divider()
                    Text("**Negative Mentions**")
                    Divider()
                }
                VStack(alignment: .leading) {
                    Divider()
                    Text("**Reddit**")
                    Divider()
                    Text("\(self.companyDetailVM.socialSentiment!.redditStats.total.withCommas())")
                        .frame(height: 47)
                    Divider()
                    Text("\(self.companyDetailVM.socialSentiment!.redditStats.positive.withCommas())")
                        .frame(height: 47)
                    Divider()
                    Text("\(self.companyDetailVM.socialSentiment!.redditStats.negative.withCommas())")
                        .frame(height: 47)
                    Divider()
                }
                VStack(alignment: .leading) {
                    Divider()
                    Text("**Twitter**")
                    Divider()
                    Text("\(self.companyDetailVM.socialSentiment!.twitterStats.total.withCommas())")
                        .frame(height: 47)
                    Divider()
                    Text("\(self.companyDetailVM.socialSentiment!.twitterStats.positive.withCommas())")
                        .frame(height: 47)
                    Divider()
                    Text("\(self.companyDetailVM.socialSentiment!.twitterStats.negative.withCommas())")
                        .frame(height: 47)
                    Divider()
                }
            }
            
            Chart(name: "RecommendationTrends", ticker: self.companyDetailVM.description!.ticker)
                .padding(.top)
                .frame(height: 450)
            
            Chart(name: "HistoricalEPS", ticker: self.companyDetailVM.description!.ticker)
                .frame(height: 450)
        }
    }
}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
