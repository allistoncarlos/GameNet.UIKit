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

enum ServiceError: Error {
    case invalidToken
}

protocol ServiceProtocol: AnyObject {
    associatedtype T: BaseModel
    
    func get(completion: @escaping (Result<APIResult<T>, Error>) -> Void) -> Void
    func load(page: Int?, pageSize: Int?, completion: @escaping (Result<APIResult<PagedResult<T>>, Error>) -> Void) -> Void
    func load(completion: @escaping (Result<APIResult<Array<T>>, Error>) -> Void) -> Void
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
    private let apiResource: String
    private let decoder = JSONDecoder()
    private let interceptor: AuthenticationInterceptor<OAuthAuthenticator>?
    
    init(apiResource: String) {
        self.apiResource = apiResource
        decoder.dateDecodingStrategy = .iso8601
        
        let keychain = Keychain(service: Constants.keychainIdentifier)
        
        guard let accessToken = keychain[Constants.accessTokenIdentifier],
              let refreshToken = keychain[Constants.refreshTokenIdentifier],
              let expiresIn = keychain[Constants.expiresInIdentifier] else {
            interceptor = nil
            return
        }
        
        let dateFormatter = ISO8601DateFormatter()
        
        guard let expiresInDate = dateFormatter.date(from: expiresIn) else { interceptor = nil; return }
        
        let authCredentials = OAuthCredential(accessToken: accessToken,
                                              refreshToken: refreshToken,
                                              expiration: Date.init(timeInterval: 60 * 5, since: expiresInDate))
        
        let container = Container()
        let userService = container.resolve(UserServiceProtocol.self)
        
        let authenticator = OAuthAuthenticator(userService: userService)
        interceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                    credential: authCredentials)
    }
    
    func get(completion: @escaping (Result<APIResult<T>, Error>) -> Void) -> Void {
        guard let url = URL(string: "\(Constants.apiPath)/\(apiResource)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        AF.request(request, interceptor: interceptor).responseDecodable(of: APIResult<T>.self, decoder: decoder) { (response) in
            switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func load(page: Int? = nil, pageSize: Int? = nil, completion: @escaping (Result<APIResult<PagedResult<T>>, Error>) -> Void) -> Void {
        var baseUrl = "\(Constants.apiPath)/\(apiResource)?";
        
        if let page = page {
            baseUrl = "\(baseUrl)page=\(page)&"
        }
        
        if let pageSize = pageSize {
            baseUrl = "\(baseUrl)pageSize=\(pageSize)&"
        }
        
        guard let url = URL(string: baseUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        AF.request(request, interceptor: interceptor).responseDecodable(of: APIResult<PagedResult<T>>.self, decoder: decoder) { (response) in
            switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func load(completion: @escaping (Result<APIResult<Array<T>>, Error>) -> Void) -> Void {
        guard let url = URL(string: "\(Constants.apiPath)/\(apiResource)?") else { return }
        
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        AF.request(request, interceptor: interceptor).responseDecodable(of: APIResult<Array<T>>.self, decoder: decoder) { (response) in
            switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
