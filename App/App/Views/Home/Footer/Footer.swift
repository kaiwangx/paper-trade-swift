//
//  Footer.swift
//  App
//
//  Created by Kai Wang on 5/3/22.
//

import SwiftUI

struct Footer: View {
    var body: some View {
        
        Link(destination: URL(string: "https://finnhub.io/")!) {
            Section {
                HStack {
                    Spacer()
                    Text("Powered by Finnhub.io")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
        }
    }
}

struct Footer_Previews: PreviewProvider {
    static var previews: some View {
        Footer()
    }
}
