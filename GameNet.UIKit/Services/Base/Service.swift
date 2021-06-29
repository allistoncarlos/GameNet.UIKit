//
//  File.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/06/21.
//

import Foundation
import Alamofire
import KeychainAccess

enum ServiceError: Error {
    case invalidToken
}

protocol ServiceProtocol: AnyObject {
    associatedtype T: BaseModel
    
    func get(completion: @escaping (Result<T, Error>) -> Void) -> Void
    func load(completion: @escaping (Result<APIResult<PagedResult<T>>, Error>) -> Void) -> Void
}

class Service<T: BaseModel>: ServiceProtocol {
    typealias T = T
    private let apiResource: String
    
    init(apiResource: String) {
        self.apiResource = apiResource
    }
    
    func get(completion: @escaping (Result<T, Error>) -> Void) -> Void {
        guard let url = URL(string: "\(Constants.apiPath)/\(apiResource)") else { return }
        
        let keychain = Keychain(service: Constants.keychainIdentifier)
        
        guard let token = keychain[Constants.tokenIdentifier] else {
            completion(.failure(ServiceError.invalidToken))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        AF.request(request).responseDecodable(of: T.self) { (response) in
            switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func load(completion: @escaping (Result<APIResult<PagedResult<T>>, Error>) -> Void) -> Void {
        guard let url = URL(string: "\(Constants.apiPath)/\(apiResource)") else { return }
        
        let keychain = Keychain(service: Constants.keychainIdentifier)
        
        guard let token = keychain[Constants.tokenIdentifier] else {
            completion(.failure(ServiceError.invalidToken))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        AF.request(request).responseDecodable(of: APIResult<PagedResult<T>>.self) { (response) in
            switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
