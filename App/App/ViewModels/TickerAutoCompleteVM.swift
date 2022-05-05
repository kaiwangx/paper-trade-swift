//
//  TickerAutoCompleteVM.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class TickerAutocompleteVM: ObservableObject {
    @Published var tickerAutocompleteList: [AutoCompleteItem] = [AutoCompleteItem]()
    
    func fetchTickerAutocompleteList(_ ticker: String) {
        AF.request("\(serverURL)/autocomplete/\(ticker)").validate().responseDecodable(of: [AutoCompleteItem].self) { response in
            switch response.result {
            case let .success(data):
                self.tickerAutocompleteList = data
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func reset() {
        tickerAutocompleteList = [AutoCompleteItem]()
    }
}
