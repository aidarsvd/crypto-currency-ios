//
//  CryptoDataManagerProtocol.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import Foundation

protocol CryptoDataManagerProtocol {
    func getList(_ callback: @escaping ([Crypto]) -> Void)
    func getDetail(id: String, callback: @escaping (CryptoDetail) -> Void)
}
