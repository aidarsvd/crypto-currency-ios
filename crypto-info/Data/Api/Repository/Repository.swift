//
//  Repository.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import Foundation

struct Repository {
    static let shared = Repository()
    let cryptoDM: CryptoDataManager
    private init(){
        cryptoDM = CryptoDataManager()
    }
}

extension Repository: CryptoDataManagerProtocol{
    func getList(_ callback: @escaping ([Crypto]) -> Void) {
        cryptoDM.getList(callback)
    }
    
    func getDetail(id: String, callback: @escaping (CryptoDetail) -> Void) {
        cryptoDM.getDetail(id: id, callback: callback)
    }
    
    
}
