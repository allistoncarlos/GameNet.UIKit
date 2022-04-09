//
//  UserAuthTests.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 09/04/22.
//

import XCTest
@testable import GameNet_UIKit

final class UserAuthTests: XCTestCase {
    // MARK: - Properties
    let mock = LoginResponseMock()
    let stubRequests = StubRequests()
    
    // MARK: - Tests
    func testLogin_ValidParameters_ShouldReturnCode200() async {
        // Given
        let username = "username"
        let password = "password"
        
        let fakeJSONResponse = mock.fakeSuccessLoginResponse
        
        stubRequests.stubJSONrespone(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: LoginResponseModel.self,
                endpoint: .login(loginRequestModel: LoginRequestModel(username: username, password: password)),
                cache: false)
        
        // Then
        XCTAssertNotNil(result)
        
        guard let result = result else { return }
        
        XCTAssertEqual(result.id, String(describing: fakeJSONResponse["id"]!))
    }
    
    func testLogin_WrongParameters_ShouldReturnCode200() async {
        // Given
        let username = "username123"
        let password = "password123"
        
        let fakeJSONResponse = mock.fakeFailureLoginResponse
        
        stubRequests.stubJSONrespone(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: LoginResponseModel.self,
                endpoint: .login(loginRequestModel: LoginRequestModel(username: username, password: password)),
                cache: false)
        
        // Then
        XCTAssertNil(result)
    }
}
