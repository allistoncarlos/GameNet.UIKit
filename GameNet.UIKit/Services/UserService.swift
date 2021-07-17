//
//  UserService.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import Foundation
import Alamofire
import KeychainAccess

protocol UserServiceProtocol: AnyObject {
    func login(loginRequestModel : LoginRequestModel,
               completion: @escaping (Result<LoginResponseModel, Error>) -> Void) -> Void
    func refreshToken(refreshTokenRequestModel: RefreshTokenRequestModel,
                      completion: @escaping (Result<RefreshTokenResponseModel, Error>) -> Void) -> Void
}

class UserService: UserServiceProtocol {
    private let decoder = JSONDecoder()
    private let keychain = Keychain(service: Constants.keychainIdentifier)
    
    init() {
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func login(loginRequestModel : LoginRequestModel,
               completion: @escaping (Result<LoginResponseModel, Error>) -> Void) -> Void {
        guard let url = URL(string: "\(Constants.apiPath)/\(Constants.userResource)/login") else { return }

        do {
            let jsonData = try JSONEncoder().encode(loginRequestModel)
            
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            AF.request(request).responseDecodable(of: LoginResponseModel.self, decoder: decoder) { (response) in
                switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
        catch {
            completion(.failure(error))
        }
    }
    
    func refreshToken(refreshTokenRequestModel: RefreshTokenRequestModel,
                      completion: @escaping (Result<RefreshTokenResponseModel, Error>) -> Void) -> Void {
        guard let url = URL(string: "\(Constants.apiPath)/\(Constants.userResource)/refresh") else { return }

        do {
            let jsonData = try JSONEncoder().encode(refreshTokenRequestModel)
            
            guard let accessToken = keychain[Constants.accessTokenIdentifier] else {
                completion(.failure(ServiceError.invalidToken))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            AF.request(request).responseDecodable(of: RefreshTokenResponseModel.self, decoder: decoder) { (response) in
                switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
        catch {
            completion(.failure(error))
        }
    }
}
