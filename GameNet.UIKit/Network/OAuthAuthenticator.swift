//
//  CoreRequestAdapter.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 17/07/21.
//

import Foundation
import Alamofire
import KeychainAccess

struct OAuthCredential: AuthenticationCredential {
    let id: String
    let accessToken: String
    let refreshToken: String
    let expiration: Date

    // Require refresh if within 5 minutes of expiration
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiration }
}

class OAuthAuthenticator: Authenticator {
    private let userService: UserServiceProtocol?

    init (userService: UserServiceProtocol?) {
        self.userService = userService
    }

    func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
    }

    func refresh(_ credential: OAuthCredential,
                 for session: Session,
                 completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
        print("VAI DAR REFRESH")

        let refreshTokenRequestModel = RefreshTokenRequestModel(
            accessToken: credential.accessToken,
            refreshToken: credential.refreshToken)

        userService?.refreshToken(refreshTokenRequestModel: refreshTokenRequestModel,
                                  completion: { (result) in
            switch result {
            case .success(let response):
            let newCredentials = OAuthCredential(
                id: response.id,
                accessToken: response.accessToken,
                refreshToken: response.refreshToken,
                expiration: response.expiresIn)

                completion(.success(newCredentials))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        })

        // Refresh the credential using the refresh token...then call completion with the new credential.
        //
        // The new credential will automatically be stored within the `AuthenticationInterceptor`. Future requests will
        // be authenticated using the `apply(_:to:)` method using the new credential.
    }

    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool {
        // If authentication server CANNOT invalidate credentials, return `false`
        return false

        // If authentication server CAN invalidate credentials, then inspect the response matching against what the
        // authentication server returns as an authentication failure. This is generally a 401 along with a custom
        // header value.
        // return response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
        // If authentication server CANNOT invalidate credentials, return `true`
        return true

        // If authentication server CAN invalidate credentials, then compare the "Authorization" header value in the
        // `URLRequest` against the Bearer token generated with the access token of the `Credential`.
        // let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        // return urlRequest.headers["Authorization"] == bearerToken
    }
}
