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
    case platform(id: String)
    case savePlatform(id: String?, model: PlatformModel)

    case lists
    case finishedByYearList(id: String)
    case boughtByYearList(id: String)
    case list(id: String)
    case saveList(id: String?, model: ListModel)

    case games(search: String?, page: Int?, pageSize: Int?)

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
        case let .platform(id):
            return "\(Constants.platformResource)/\(id)"
        case let .savePlatform(id, _):
            if let id = id {
                return "\(Constants.platformResource)?id=\(id)"
            }

            return "\(Constants.platformResource)/"

        case .lists:
            return Constants.listResource
        case let .finishedByYearList(id):
            return "\(Constants.listResource)/FinishedByYear/\(id)"
        case let .boughtByYearList(id):
            return "\(Constants.listResource)/BoughtByYear/\(id)"
        case let .list(id):
            return "\(Constants.listResource)/\(id)"
        case let .saveList(id, _):
            if let id = id {
                return "\(Constants.listResource)?id=\(id)"
            }

            return Constants.listResource

        case let .games(search, page, pageSize):
            var resultUrl = "\(Constants.gameResource)?"

            if let search = search {
                resultUrl = "\(resultUrl)search=\(search)&"
            }

            if let page = page {
                resultUrl = "\(resultUrl)page=\(page)&"
            }

            if let pageSize = pageSize {
                resultUrl = "\(resultUrl)pageSize=\(pageSize)&"
            }

            return resultUrl
        }
    }

    var method: HTTPMethod {
        switch self {
        case .dashboard,
             .platforms,
             .platform,

             .lists,
             .finishedByYearList,
             .boughtByYearList,
             .list,

             .games:
            return .get
        case .login,
             .refreshToken:
            return .post
        case let .savePlatform(id, _):
            if id != nil {
                return .put
            }

            return .post
        case let .saveList(id, _):
            if id != nil {
                return .put
            }

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
        case let .saveList(_, model):
            return try parameterEncoder.encode(model, into: request)
        case let .savePlatform(_, model):
            return try parameterEncoder.encode(model, into: request)
        case .refreshToken:
            return request
        case .dashboard,
             .platforms,
             .platform,

             .lists,
             .finishedByYearList,
             .boughtByYearList,
             .list,

             .games:
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
        let resultUrl = "\(baseURL)/\(path)"

        let url = try resultUrl.asURL()
        var request = URLRequest(url: url)
        request.method = method

        return try encodeParameters(into: request)
    }
}
