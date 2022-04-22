//
//  TickerLastPrice.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import Foundation
import SwiftUI

struct TickerLastPrice: Decodable {
    var current: Double
    var change: Double
    var percentageChange: Double
    var high: Double
    var low: Double
    var open: Double
    var previousClose: Double
    var timeStamp: Int
    var trend: Trend {
        if percentageChange > 0 {
            return Trend(color: Color.green, img:Image(systemName: "arrow.up.forward"))
        } else if percentageChange < 0 {
            return Trend(color:Color.red, img:Image(systemName: "arrow.down.forward"))
        } else {
            return Trend(color:Color.gray, img:Image(systemName: "minus"))
        }
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case current = "c"
        case change = "d"
        case percentageChange = "dp"
        case high = "h"
        case low = "l"
        case open = "o"
        case previousClose = "pc"
        case timeStamp = "t"
    }
}

struct Trend {
    var color: Color
    var img: Image
}
