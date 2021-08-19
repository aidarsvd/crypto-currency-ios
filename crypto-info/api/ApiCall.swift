//
//  ApiFile.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import Alamofire
import Foundation

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
    static let serverError = 500 ..< 526
    static let invalidToken = 401
}

protocol APICall {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parametres: Parameters? { get }
}

extension APICall {
    private func handleRequest(response: AFDataResponse<Any>, _ handler: @escaping (String?) -> Void) {
        guard let answer = response.response else { return }
        if HTTPCodes.success ~= answer.statusCode {
            handler(nil)
            debugPrint("call with \(UUID())")
        } else {
            if HTTPCodes.serverError ~= answer.statusCode {
                handler("Ошибка сервера")
            } else if HTTPCodes.invalidToken == answer.statusCode {
                // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "logout"), object: nil)
            } else {
                guard let data = response.data else { return }
                handler(String(data: data, encoding: .utf8) ?? "")
            }
        }
    }

    func urlRequest(baseURL: String, _ handler: @escaping (String?) -> Void) throws -> DataRequest {
        guard let url = URL(string: baseURL + path) else {
            throw AFError.invalidURL(url: baseURL + path)
        }

        let request = Api.shared.manager.request(url, method: method, parameters: parametres, headers: headers).validate()
        request.responseJSON { res in
            handleRequest(response: res, handler)
        }
        return request
    }
}
