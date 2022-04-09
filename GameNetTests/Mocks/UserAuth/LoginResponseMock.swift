//
//  LoginResponseMock.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 09/04/22.
//

import Foundation

final class LoginResponseMock {
    let fakeSuccessLoginResponse: [String: Any] = [
        "id": "60d488293531bbbf8a1c8123",
        "username": "user",
        "firstName": "First",
        "lastName": "Name",
        "access_token": "accessToken123",
        "refresh_token": "RefreshToken123",
        "expires_in": "2022-04-09T19:57:56Z"
    ]
    
    let fakeFailureLoginResponse: [String: Any] = [
        "message": "Username or password is incorrect"
    ]
}
