//
//  File.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/06/21.
//

import Foundation
import Alamofire
import KeychainAccess
import Swinject

#if !PRODUCTION
import Logging
import Pulse
#endif

enum ServiceError: Error {
    case invalidToken
}

protocol ServiceProtocol: AnyObject {
    associatedtype T: BaseModel

    func get(id: String?, completion: @escaping (Result<APIResult<T>, Error>) -> Void)
    func load(page: Int?,
              pageSize: Int?,
              search: String?,
              completion: @escaping (Result<APIResult<PagedResult<T>>, Error>) -> Void)
    func load(completion: @escaping (Result<APIResult<[T]>, Error>) -> Void)

    func save(
        id: String?,
        model: T,
        completion: @escaping (Result<APIResult<T>, Error>) -> Void)
}

struct ServiceBox<T: ServiceProtocol> {
    typealias U = T

    let objectType: U.Type
    let object: U

    init(object: U) {
        self.object = object
        self.objectType = U.self
    }
}

class Service<T: BaseModel>: ServiceProtocol {
    typealias T = T

    let apiResource: String
    let decoder = JSONDecoder()
//    let interceptor: AuthenticationInterceptor<OAuthAuthenticator>?

    let sessionManager: Session = {
        var configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 60
        configuration.waitsForConnectivity = true
        #if !PRODUCTION
            let logger = NetworkLogger()
            return Session(configuration: configuration, eventMonitors: [NetworkLoggerEventMonitor(logger: logger)])
        #elseif PRODUCTION
            return Session(configuration: configuration)
        #endif

    }()

    init(apiResource: String) {
        self.apiResource = apiResource
        decoder.dateDecodingStrategy = .iso8601

        let keychain = Keychain(service: Constants.keychainIdentifier)

//        guard let id = keychain[Constants.userIdIdentifier],
//              let accessToken = keychain[Constants.accessTokenIdentifier],
//              let refreshToken = keychain[Constants.refreshTokenIdentifier],
//              let expiresIn = keychain[Constants.expiresInIdentifier] else {
//            interceptor = nil
//            return
//        }

        let dateFormatter = ISO8601DateFormatter()

//        guard let expiresInDate = dateFormatter.date(from: expiresIn) else { interceptor = nil; return }
//
//        let authCredentials = OAuthCredential(
//            id: id,
//            accessToken: accessToken,
//            refreshToken: refreshToken,
//            expiration: Date.init(timeInterval: 60 * 5, since: expiresInDate))

        let container = Container()
//        let userService = container.resolve(UserServiceProtocol.self)

//        let authenticator = OAuthAuthenticator(userService: userService)
//        interceptor = AuthenticationInterceptor(authenticator: authenticator,
//                                                    credential: authCredentials)

    }

    func baseGet<TModel: BaseModel>(id: String? = nil,
                                    queryString: String? = nil,
                                    completion: @escaping (Result<APIResult<TModel>, Error>) -> Void) {
        var urlString = "\(Constants.apiPath)/\(apiResource)"

        if let id = id {
            urlString = "\(urlString)/\(id)"
        }

        if let queryString = queryString {
            urlString = "\(urlString)?\(queryString)"
        }

        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")

//        sessionManager.request(request, interceptor: interceptor)
        sessionManager.request(request)
            .responseDecodable(of: APIResult<TModel>.self, decoder: decoder) { (response) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func get<TModel: BaseModel>(relativeUrl: String,
                                completion: @escaping (Result<APIResult<[TModel]>, Error>) -> Void) {
        let urlString = "\(Constants.apiPath)/\(apiResource)\(relativeUrl)"

        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")

//        sessionManager.request(request, interceptor: interceptor)
        sessionManager.request(request)
            .responseDecodable(of: APIResult<[TModel]>.self, decoder: decoder) { (response) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func get<TModel: BaseModel>(relativeUrl: String,
                                completion: @escaping (Result<APIResult<TModel>, Error>) -> Void) {
        let urlString = "\(Constants.apiPath)/\(apiResource)\(relativeUrl)"

        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")

//        sessionManager.request(request, interceptor: interceptor)
        sessionManager.request(request)
            .responseDecodable(of: APIResult<TModel>.self, decoder: decoder) { (response) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func get(id: String? = nil, completion: @escaping (Result<APIResult<T>, Error>) -> Void) {
        self.baseGet(id: id, completion: completion)
    }

    func load(page: Int? = nil,
              pageSize: Int? = nil,
              search: String? = nil,
              completion: @escaping (Result<APIResult<PagedResult<T>>, Error>) -> Void) {
        var baseUrl = "\(Constants.apiPath)/\(apiResource)?"

        if let page = page {
            baseUrl = "\(baseUrl)page=\(page)&"
        }

        if let pageSize = pageSize {
            baseUrl = "\(baseUrl)pageSize=\(pageSize)&"
        }

        if let search = search {
            baseUrl = "\(baseUrl)search=\(search)&"
        }

        guard let url = URL(string: baseUrl) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")

//        sessionManager.request(request, interceptor: interceptor)
        sessionManager.request(request)
            .responseDecodable(of: APIResult<PagedResult<T>>.self, decoder: decoder) { (response) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func load(completion: @escaping (Result<APIResult<[T]>, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.apiPath)/\(apiResource)?") else { return }

        print(url)

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")

//        sessionManager.request(request, interceptor: interceptor)
        sessionManager.request(request)
            .responseDecodable(of: APIResult<[T]>.self, decoder: decoder) { (response) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func save(id: String?,
              model: T,
              completion: @escaping (Result<APIResult<T>, Error>) -> Void) {
        do {
            let urlString = "\(Constants.apiPath)/\(apiResource)?"

            var request: URLRequest

            if let id = id {
                guard let url = URL(string: urlString + "id=\(id)") else { return }

                request = URLRequest(url: url)
                request.httpMethod = HTTPMethod.put.rawValue
            } else {
                guard let url = URL(string: urlString) else { return }

                request = URLRequest(url: url)
                request.httpMethod = HTTPMethod.post.rawValue
            }

            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601

            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = try encoder.encode(model)

            let json = String(data: request.httpBody!, encoding: .utf8)
            print(json!)

//            sessionManager.request(request, interceptor: interceptor)
            sessionManager.request(request)
                .responseDecodable(of: APIResult<T>.self, decoder: decoder) { (response) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
}
