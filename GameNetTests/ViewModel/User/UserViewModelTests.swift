//
//  UserViewModelTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 09/04/22.
//

import XCTest
import GameNet_Keychain
@testable import GameNet_UIKit

final class UserViewModelTests: XCTestCase {
    // MARK: - Properties
    let mock = LoginResponseMock()
    let stubRequests = StubRequests()
    var viewModel: UserViewModelProtocol?
    
    // MARK: - SetUp/TearDown
    override func setUp() {
        super.setUp()
        
        viewModel = UserViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        KeychainDataSource.clear()
    }
    
    // MARK: - Tests
    func testLogin_ValidParameters_ShouldReturnValidAccessToken() async {
        // Given
        let username = "username"
        let password = "password"
        
        let fakeJSONResponse = mock.fakeSuccessLoginResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        let result = await viewModel?.login(username: username, password: password)
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(KeychainDataSource.accessToken.get(), String(describing: fakeJSONResponse["access_token"]!))
    }
    
    func testLogin_InvalidParameters_ShouldReturnNil() async {
        // Given
        let username = "username123"
        let password = "password123"
        
        let fakeJSONResponse = mock.fakeFailureLoginResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        let result = await viewModel?.login(username: username, password: password)
        
        // Then
        XCTAssertNil(result)
        XCTAssertNil(KeychainDataSource.accessToken.get())
    }
}
