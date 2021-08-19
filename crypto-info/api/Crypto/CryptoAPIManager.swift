//
//  Crypto.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import Foundation
import Combine
import Alamofire

struct CryptoAPIManager: APIManagerProtocol {
    
    static let shared = CryptoAPIManager()
    
    let baseURL: String = Constant.baseUrl
    
    func getList() -> AnyPublisher<[Crypto], AFError> {
        return call(endpoint: API.getList){ _ in
        }
    }
    
    func getDetail(id: String) -> AnyPublisher<Crypto, AFError>{
        return call(endpoint: API.getDetail(id: id)) { _ in
        }
    }
    
}

extension CryptoAPIManager{
    enum API {
        case getList
        case getDetail(id: String)
    }
}

extension CryptoAPIManager.API: APICall{
    var parametres: Parameters? {
        switch self {
        case .getList:
            let parameters: Parameters = ["vs_currency": "usd", "order": "market_cap_desc", "per_page": "50", "price_change_percentage": "24h", "page": "1"]
            return parameters
        case .getDetail(_):
            let parameters: Parameters = ["vs_currency": "usd", "order": "market_cap_desc", "price_change_percentage": "24h"]
            return parameters        }
    }
    
    var path: String {
        switch self {
        case .getList:
            return "coins/markets"
        case .getDetail(let id):
            return "coins/\(id)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
