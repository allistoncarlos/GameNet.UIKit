//
//  GameService.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/06/21.
//

import Foundation
import Alamofire

protocol GameServiceProtocol: ServiceProtocol {
    func getGameDetail(id: String?, completion: @escaping (Result<APIResult<GameDetailModel>, Error>) -> Void)

    func save(
        model: GameEditModel,
        completion: @escaping (Result<APIResult<GameEditResponseModel>, Error>) -> Void)
}

class GameService: Service<GameModel>, GameServiceProtocol {
    typealias T = GameModel

    func getGameDetail(id: String? = nil, completion: @escaping (Result<APIResult<GameDetailModel>, Error>) -> Void) {
        super.baseGet(id: id, completion: completion)
    }

    func save(
        model: GameEditModel,
        completion: @escaping (Result<APIResult<GameEditResponseModel>, Error>) -> Void) {
            var urlString = "\(Constants.apiPath)/game?"

            if let id = model.id {
                urlString += "id=\(id)"
            }

            let uploadClosure: (MultipartFormData) -> Void = { multipartFormData in
                multipartFormData.append(Data(model.name.utf8),
                                         withName: "Name")
                multipartFormData.append(Data(model.platformId.utf8),
                                         withName: "PlatformId")

                multipartFormData.append(model.cover, withName: "file", fileName: "file.png", mimeType: "image/jpeg")
            }

            let result = AF.upload(multipartFormData: uploadClosure,
                                   to: urlString,
                                   interceptor: interceptor) { request in
                request.headers.update(name: "Content-Type", value: "multipart/form-data; charset=UTF-8")
            }

            result.responseDecodable(of: APIResult<GameEditResponseModel>.self, decoder: decoder) { (response) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

    func saveUserGame(model: UserGameEditModel,
                      completion: @escaping (Result<APIResult<UserGameEditResponseModel>, Error>) -> Void) {
        do {
            let urlString = "\(Constants.apiPath)/\(apiResource)?"

            var request: URLRequest

            guard let url = URL(string: urlString) else { return }

            request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue

            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601

            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = try encoder.encode(model)

            let json = String(data: request.httpBody!, encoding: .utf8)
            print(json!)

            AF.request(request, interceptor: interceptor)
                .responseDecodable(of: APIResult<UserGameEditResponseModel>.self, decoder: decoder) { (response) in
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
