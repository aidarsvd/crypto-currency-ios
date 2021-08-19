//
//  Crypto.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import Foundation

struct Crypto: Codable, Identifiable {
    var id: String = ""
    var name: String = ""
    var image: String = ""
    var current_price: Double = 0.0
    var price_change_percentage_24h: Double = 0.0
    var market_cap_rank: Int = 0
}
