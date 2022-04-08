//
//  NetworkManager.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 08/04/22.
//

import Foundation
import Alamofire

class NetworkManager {
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

        let defaultEventMonitor = DefaultEventMonitor()
        let requestsInterceptor = DefaultRequestInterceptor()

        return Session(
            configuration: configuration,
            interceptor: requestsInterceptor,
            cachedResponseHandler: responseCacher,
            eventMonitors: [defaultEventMonitor])
    }()

    func performRequest<T: Decodable>(model: T.Type, endpoint: GameNetAPI) async -> (Result<T, Error>) {
        await withUnsafeContinuation({ continuation in
            self.sessionManager.request(endpoint)
                .validate(statusCode: 200...300)
                .responseDecodable(of: T.self, completionHandler: { response in
                    switch response.result {
                    case .success:
                        guard let value = response.value else {return}
                        continuation.resume(returning: .success(value))
                    case .failure(let error):
                        continuation.resume(returning: .failure(error))
                    }
                })
        })
    }

    func performRequestAsync<T: Decodable>(model: T.Type, endpoint: GameNetAPI) async -> T? {
        do {
            let request = self.sessionManager.request(endpoint)
                .validate(statusCode: 200...300)

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
