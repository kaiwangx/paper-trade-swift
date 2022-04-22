//
//  SocialSentiment.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import Foundation

struct SocialSentiment: Decodable {
    var reddit: [SocialSentimentItem]
    var twitter: [SocialSentimentItem]
    
    var redditStats: SocialSentimentStat { getSocialSentimentStats(reddit) }
    
    var twitterStats: SocialSentimentStat { getSocialSentimentStats(twitter) }
}

func getSocialSentimentStats(_ arr: [SocialSentimentItem]) -> SocialSentimentStat {
    var mention = 0, positve = 0, negative = 0
    arr.forEach { sentiment in
        mention += sentiment.mention
        positve += sentiment.positiveMention
        negative += sentiment.negativeMention
    }
    return SocialSentimentStat(total: mention, positive: positve, negative: negative)
}

struct SocialSentimentItem: Decodable {
    var mention: Int
    var positiveMention: Int
    var negativeMention: Int
}

struct SocialSentimentStat {
    var total: Int
    var positive: Int
    var negative: Int
}

