//
//  CryptoDataManager.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import Alamofire
import Combine
import Foundation

class CryptoDataManager: CryptoDataManagerProtocol{

    var bag: Set<AnyCancellable> = []
    
    private func fetchAPIRequest<T>(with publisher: AnyPublisher<T, AFError>, onSuccess: @escaping (T) -> Void, onError: @escaping (String) -> Void) {
        publisher
            .receive(on: RunLoop.main)
            .mapError { error -> Error in
                print("error \(error)")
                return error
            }
            .sink(receiveCompletion: { _ in }, receiveValue: { response in
                onSuccess(response)
            })
            .store(in: &bag)
    }

    func getList(_ callback: @escaping ([Crypto]) -> Void) {
        fetchAPIRequest(with: CryptoAPIManager.shared.getList(), onSuccess: callback) { error in
            callback([Crypto]())
        }
    }
    
    func getDetail(id: String, callback: @escaping (CryptoDetail) -> Void) {
        fetchAPIRequest(with: CryptoAPIManager.shared.getDetail(id: id), onSuccess: callback) { error in
            callback(CryptoDetail())
        }
    }
}
