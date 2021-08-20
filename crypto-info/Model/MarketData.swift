//
//  MarketData.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 20/8/21.
//

import Foundation

struct MarketData: Codable {
    var current_price: Price = Price()
    var high_24h: Price = Price()
    var low_24h: Price = Price()
    var price_change_24h: Double = 0.0
    var price_change_percentage_24h: Double = 0.0
    var sparkline_7d: Sparkline = Sparkline()
}
