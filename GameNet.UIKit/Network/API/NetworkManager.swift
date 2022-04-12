//
//  NetworkManager.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 08/04/22.
//

import Foundation
import Alamofire
import Pulse

final class NetworkManager {
    static let shared = NetworkManager()

    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad

        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })

        let pulseLogger = NetworkLogger()
        let pulseNetworkLoggerEventMonitor = NetworkLoggerEventMonitor(logger: pulseLogger)

        let defaultEventMonitor = DefaultEventMonitor()
        let requestsInterceptor = DefaultRequestInterceptor()

        return Session(
            configuration: configuration,
            interceptor: requestsInterceptor,
            cachedResponseHandler: responseCacher,
            eventMonitors: [defaultEventMonitor, pulseNetworkLoggerEventMonitor])
    }()

    @discardableResult
    func performRequest<T: Decodable>(model: T.Type, endpoint: GameNetAPI, cache: Bool = false) async -> T? {
        do {
            let request = self.sessionManager.request(endpoint)
                .validate(statusCode: 200...300)
                .cacheResponse(using: cache ? .cache : .doNotCache)

            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            let response = try await request.serializingDecodable(T.self, decoder: jsonDecoder).value

            return response
        } catch let error {
            print(error)
            return nil
        }
    }
}
