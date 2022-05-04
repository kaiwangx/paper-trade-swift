//
//  CompanyDetailVM.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

class CompanyDetailVM: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var description: CompanyDescription?
    @Published var price: TickerLastPrice?
    @Published var peers: [String]?
    @Published var socialSentiment: SocialSentiment?
    @Published var newsList: [NewsItem]?
    
    init(_ ticker: String) {
        print("new ticker search of \(ticker)")
        self.fetchCompanyDescription(ticker)
        self.fetchCompanyPrice(ticker)
        self.fetchPeers(ticker)
        self.fetchSocialSentiment(ticker)
        self.fetchNews(ticker)
    }
    
    func fetchCompanyDescription(_ ticker: String) {
        AF.request("\(serverURL)/description/\(ticker)").validate().responseDecodable(of: CompanyDescription.self) { response in
            switch response.result {
            case let .success(data):
                self.description = data
                self.updateLoadingState()
            case let .failure(error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchCompanyPrice(_ ticker: String) {
        AF.request("\(serverURL)/latest_price/\(ticker)").validate().responseDecodable(of: TickerLastPrice.self) { response in
            switch response.result {
            case let .success(data):
                self.price = data
                self.updateLoadingState()
            case let .failure(error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchPeers(_ ticker: String) {
        AF.request("\(serverURL)/peers/\(ticker)").validate().responseDecodable(of: [String].self) { response in
            switch response.result {
            case let .success(data):
                self.peers = data
                self.updateLoadingState()
            case let .failure(error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchSocialSentiment(_ ticker: String) {
        AF.request("\(serverURL)/social_sentiment/\(ticker)").validate().responseDecodable(of: SocialSentiment.self) { response in
            switch response.result {
            case let .success(data):
                self.socialSentiment = data
                self.updateLoadingState()
            case let .failure(error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchNews(_ ticker: String) {
        let to = Date()
        let from = to - 7 * 24 * 60 * 60
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        AF.request("\(serverURL)/news/\(ticker)/\(dateFormatter.string(from: from))/\(dateFormatter.string(from: to))").validate().responseDecodable(of: [NewsItem].self) { response in
            switch response.result {
            case let .success(data):
            let filterNews: [NewsItem] = data.filter({$0.source != "" && $0.image != "" && $0.datetime != 0 && $0.headline != "" && $0.summary != ""  && $0.url != ""})
                self.newsList = filterNews
                self.updateLoadingState()
            case let .failure(error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    
    func updateLoadingState() {
        if self.description != nil &&
            self.price != nil &&
            self.peers != nil &&
            self.socialSentiment != nil &&
            self.newsList != nil {
            self.isLoading = false
        }
    }
}
