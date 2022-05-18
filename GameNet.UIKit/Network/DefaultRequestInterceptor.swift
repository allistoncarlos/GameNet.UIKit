//
//  DefaultRequestInterceptor.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 08/04/22.
//

import Foundation
import Alamofire

class DefaultRequestInterceptor: RequestInterceptor {
    let retryLimit = 3
    let retryDelay: TimeInterval = 10

    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest

        if let accessToken = KeychainDataSource.accessToken.get() {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            urlRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        }

        completion(.success(urlRequest))
    }

    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        let response = request.task?.response as? HTTPURLResponse

        if let statusCode =
            response?.statusCode, (500...599).contains(statusCode),
           request.retryCount < retryLimit {
            completion(.retryWithDelay(retryDelay))
        } else {
            return completion(.doNotRetry)
        }
    }
}
