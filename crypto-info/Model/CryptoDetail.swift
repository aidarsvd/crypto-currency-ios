//
//  CryptoDetail.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 20/8/21.
//

import Foundation

struct CryptoDetail: Codable {
    var id: String = ""
    var name: String = ""
    var image: CoinImage = CoinImage()
    var description: Description = Description()
    var market_data: MarketData = MarketData()
}
