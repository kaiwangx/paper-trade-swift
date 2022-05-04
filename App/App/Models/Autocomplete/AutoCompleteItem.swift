//
//  AutoCompleteItem.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import Foundation

struct AutoCompleteItem: Identifiable, Decodable {
    var id: String {symbol}
    var symbol: String
    var description: String
}
