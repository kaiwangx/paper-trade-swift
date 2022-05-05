//
//  PriceCharts.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI

struct PriceCharts: View {
    var ticker: String
    var body: some View {
        TabView {
            Chart(name: "Hourly", ticker: self.ticker)
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                    Text("Hourly")
                }
                .frame(height: 420)
            
            Chart(name: "Historical", ticker: self.ticker)
                .tabItem {
                    Image(systemName: "clock")
                    Text("Historical")
                }
                .frame(height: 420)
        }
    }
}

struct PriceCharts_Previews: PreviewProvider {
    static var previews: some View {
        PriceCharts(ticker: "TSLA")
    }
}

