//
//  APIManagerProtocol.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import Alamofire
import Combine
import Foundation

protocol APIManagerProtocol {
    var baseURL: String { get }
}

extension APIManagerProtocol {

    func call<Output>(endpoint: APICall, httpCodes _: HTTPCodes = .success, _ handler: @escaping (String?) -> Void) -> AnyPublisher<Output, AFError>
        where Output: Codable
    {
        let decoder = JSONDecoder()
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL) { res in
                if res != nil {
                    handler(res)
                }
            }
            let result = request.publishDecodable(type: Output.self, decoder: decoder)
            return result.value()
        } catch {
            return Fail<Output, AFError>(error: error.asAFError(orFailWith: "error fail")).eraseToAnyPublisher()
        }
    }
}
