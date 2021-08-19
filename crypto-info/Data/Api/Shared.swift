//
//  Shared.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import Alamofire
import Combine
import Foundation

class Api {
    static var shared = Api()
    let retryLimit = 1
    var isCancelAllLongPollingRequests: Bool = false

    final class AlamofireLogger: EventMonitor {
        func requestDidResume(_ request: Request) {
            let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
            let message = """
            \n
            ⚡️ Request Started: \(request)
            ⚡️ Body Data: \(body)
            """

            // swiftlint:disable print_using
            NSLog(message)
        }

        func request<Value>(_: DataRequest, didParseResponse response: AFDataResponse<Value>) {
            // swiftlint:disable print_using
            print("\n ⚡️ Response Received: \(response.debugDescription)")
            NSLog("\n ⚡️-------------------------------------⚡️")

            switch response.result {
            case .failure:
                print("\n ⚡️ Response Received: \(response.debugDescription)")
                print("\n ⚡️-------------------------------------⚡️")

            default:
                break
            }
        }
    }

    let manager: Session = {
        let configuration = URLSessionConfiguration.default
        let manager = Session(
            configuration: configuration,
            eventMonitors: [AlamofireLogger()]
        )
        return manager
    }()
}
