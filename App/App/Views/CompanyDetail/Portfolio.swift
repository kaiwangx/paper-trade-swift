//
//  Portfolio.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI

struct Portfolio: View {
    @State var ticker: String
    var body: some View {
        VStack(alignment: .leading){
            Text("Portfolio")
                .font(.title)
                .padding(.bottom, 5)
            HStack(alignment: .center) {
                VStack(alignment: .leading){
                    // if statement
                    Text("Your have 0 shares of \(self.ticker).")
                    Text("Start trading!")
                }
                Spacer()
                VStack {
                    Button("Trade", action: {})
                        .padding(.horizontal, 50)
                        .padding(.vertical, 12)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(30)
                }
            }
        }
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        Portfolio(ticker: "TSLA")
    }
}
