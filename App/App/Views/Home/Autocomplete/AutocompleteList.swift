//
//  AutocompleteList.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI

struct AutocompleteList: View {
    var tickerAutocompleteList: [AutoCompleteItem]
    var body: some View {
        List {
            ForEach(tickerAutocompleteList) { option in
                NavigationLink{
                    LazyView(CompanyDetail(ticker: option.symbol))
                } label: {
                    VStack(alignment: .leading) {
                        Text(option.symbol)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(option.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}
