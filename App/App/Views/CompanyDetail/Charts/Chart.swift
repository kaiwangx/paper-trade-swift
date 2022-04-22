//
//  Chart.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI

struct Chart: View {
    @State var title: String = ""
    @State var error: Error? = nil
    var name: String
    var ticker: String
    
    var body: some View {
        NavigationView {
            WebView(title: $title, ticker: self.ticker, name: self.name)
                .onLoadStatusChanged { loading, error in
                    if loading {
                        print("Loading started")
                        self.title = "Loading…"
                    }
                    else {
                        print("Done loading.")
                        if let error = error {
                            self.error = error
                            if self.title.isEmpty {
                                self.title = "Error"
                            }
                        }
                        else if self.title.isEmpty {
                            self.title = "Some Place"
                        }
                    }
            }
            .navigationBarTitle(title)
        }
    }
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        Chart(name: "HistoricalEPS", ticker: "TSLA")
    }
}

