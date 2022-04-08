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
    case dashboard

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
        case .dashboard:
            return Constants.dashboardResource
        }
    }

    var method: HTTPMethod {
        switch self {
        case .dashboard:
            return .get
        case .login:
            return .post
        }
    }

    var parameterEncoder: ParameterEncoder {
        switch self {
        case .login:
            let encoder = JSONParameterEncoder()
            encoder.encoder.dateEncodingStrategy = .iso8601
            return encoder
        case .dashboard: return URLEncodedFormParameterEncoder()
        }
    }

    func encodeParameters(into request: URLRequest) throws -> URLRequest {
        switch self {
        case let .login(parameters): return try parameterEncoder.encode(parameters, into: request)
        case .dashboard: return request
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
