//
//  GameNetAPI.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 08/04/22.
//

import Foundation
import Alamofire

enum GameNetAPI {
    case login(loginRequestModel: LoginRequestModel)
    case refreshToken
    case dashboard
    case platforms

    case lists
    case finishedByYearList(id: String)
    case boughtByYearList(id: String)
    case list(id: String)

    var baseURL: String {
        switch self {
        default:
            return Constants.apiPath
        }
    }

    var path: String {
        switch self {
        case .login:
            return "\(Constants.userResource)/login"
        case .refreshToken:
            return "\(Constants.userResource)/refresh"
        case .dashboard:
            return Constants.dashboardResource
        case .platforms:
            return Constants.platformResource

        case .lists:
            return Constants.listResource
        case let .finishedByYearList(id):
            return "\(Constants.listResource)/FinishedByYear/\(id)"
        case let .boughtByYearList(id):
            return "\(Constants.listResource)/BoughtByYear/\(id)"
        case let .list(id):
            return "\(Constants.listResource)/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .dashboard,
             .platforms,
             .lists,
             .finishedByYearList,
             .boughtByYearList,
             .list:
            return .get
        case .login,
             .refreshToken:
            return .post
        }
    }

    var parameterEncoder: ParameterEncoder {
        switch method {
        case .get: return URLEncodedFormParameterEncoder()
        default:
            let encoder = JSONParameterEncoder()
            encoder.encoder.dateEncodingStrategy = .iso8601
            return encoder
        }
    }

    func encodeParameters(into request: URLRequest) throws -> URLRequest {
        switch self {
        case let .login(parameters):
            return try parameterEncoder.encode(parameters, into: request)
        case .refreshToken:
            return request
        case .dashboard,
             .platforms,
             .lists,
             .finishedByYearList,
             .boughtByYearList,
             .list:
            return request
        }
    }

    var accessToken: String? {
        return KeychainDataSource.accessToken.get()
    }

    var refreshToken: String? {
        return KeychainDataSource.refreshToken.get()
    }

    var isRefreshToken: Bool {
        switch self {
        case .refreshToken:
            return true
        default:
            return false
        }
    }
}

extension GameNetAPI: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL().appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method

        return try encodeParameters(into: request)
    }
}