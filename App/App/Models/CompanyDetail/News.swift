//
//  News.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import Foundation

struct NewsItem: Decodable, Identifiable{
    var category: String
    var datetime: Int
    var headline: String
    var id: Int
    var image: String
    var related: String
    var source: String
    var summary: String
    var url: String
    
    var publishDate: Date {
        Date(timeIntervalSince1970: TimeInterval(datetime))
    }
    
    var timeSincePublished: String {
        let formatter = DateComponentsFormatter()

        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        formatter.allowedUnits = [.day, .hour, .minute]

        return formatter.string(from: -publishDate.timeIntervalSinceNow)!
    }
    
    var facebookShareLink: URL {
        URL(string: replaceSpace("https://www.facebook.com/sharer/sharer.php?u=\(url)"))!
    }
    
    var twitterShareLink: URL {
        return URL(string: replaceSpace("https://twitter.com/intent/tweet?text=\(headline)%0A\(url)"))!
    }
    
    func replaceSpace(_ path: String) -> String {
        return path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
