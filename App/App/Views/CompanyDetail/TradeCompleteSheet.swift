//
//  TradeCompleteSheet.swift
//  App
//
//  Created by Kai Wang on 4/23/22.
//

import SwiftUI

struct TradeCompleteSheet: View {
    var companyName: String
    var numOfShares: String
    var type: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            Text("Congratulations!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("You have successfully \(type) \(numOfShares) shares of \(companyName)")
                .foregroundColor(.white)
                .padding(.top, 10)
            Spacer()
            Button {
                dismiss()
            } label: {
                HStack {
                    Spacer()
                    Text("Done")
                    Spacer()
                }
                .foregroundColor(Color(red: 0/255, green: 190/255, blue: 5/255))
                .font(.callout)
                .padding(.vertical, 12)
                .background(.white)
                .cornerRadius(30)
            }
            .padding(.bottom)
        }
        .padding(.horizontal, 20.0)
        .background(Color(red: 0/255, green: 190/255, blue: 5/255))
    }
}

struct TradeCompleteSheet_Previews: PreviewProvider {
    static var previews: some View {
        
        TradeCompleteSheet(companyName: "AAPL", numOfShares: "2", type: "sold")
    }
}
