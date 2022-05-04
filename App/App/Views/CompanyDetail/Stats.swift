//
//  Stats.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI

struct Stats: View {
    var price: TickerLastPrice
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Stats")
                    .font(.title)
                    .padding(.bottom, 5)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("**High Price**: $\(self.price.high, specifier: "%.2f")")
                        .padding(.bottom, 3)
                    Text("**Low Price**: $\(self.price.low, specifier: "%.2f")")
                }
                .padding(.trailing)
                VStack(alignment: .leading) {
                    Text("**Open Price**: $\(self.price.open, specifier: "%.2f")")
                        .padding(.bottom, 3)
                    Text("**Prev. Close**: $\(self.price.previousClose, specifier: "%.2f")")
                }
                Spacer()
            }
        }
    }
}
