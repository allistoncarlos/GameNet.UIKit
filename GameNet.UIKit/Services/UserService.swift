//
//  UserService.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import Foundation
import Alamofire

protocol UserServiceProtocol: AnyObject {
    func login(LoginRequestModel : LoginRequestModel,
               completion: @escaping (Result<LoginResponseModel, Error>) -> Void) -> Void
}

class UserService: UserServiceProtocol {
    func login(LoginRequestModel : LoginRequestModel,
               completion: @escaping (Result<LoginResponseModel, Error>) -> Void) -> Void {
        guard let url = URL(string: "\(Constants.apiPath)/\(Constants.userResource)/login") else { return }

        do {
            let jsonData = try JSONEncoder().encode(LoginRequestModel)
            
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            AF.request(request).responseDecodable(of: LoginResponseModel.self) { (response) in
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
