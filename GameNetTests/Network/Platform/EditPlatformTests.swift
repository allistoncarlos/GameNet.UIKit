//
//  EditPlatformTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 12/04/22.
//

import XCTest
import GameNet_Network
import GameNet_Keychain
@testable import GameNet_UIKit

final class EditPlatformTests: XCTestCase {
    // MARK: - Properties
    let mock = PlatformsResponseMock()
    let stubRequests = StubRequests()
    
    // MARK: - SetUp/TearDown
    override func tearDown() {
        super.tearDown()
        KeychainDataSource.clear()
        URLCache.shared.removeAllCachedResponses()
    }
    
    // MARK: - Tests
    func testFetchPlatform_ShouldReturnValidData() async {
        // Given
        let id = "123"
        let fakeJSONResponse = mock.fakeSuccessPlatformResponse

        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: Constants.platformResource)

        // When
        let result = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<PlatformResponse>.self,
                endpoint: .platform(id: id))

        // Then
        XCTAssertNotNil(result)

        let dictionary = fakeJSONResponse as NSDictionary
        let platform = dictionary.value(forKeyPath: "data") as? [String: Any?]
        let resultName = result?.data.name
        let expectedName = platform?["name"] as? String

        XCTAssertEqual(resultName, expectedName)
    }
    
    func testSaveNewPlatform_ValidParameters_ShouldReturnValidPlatforms() async {
        // Given
        let name = "Nova Plataforma"
        let fakeJSONResponse = mock.fakeSaveNewPlatformResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 201, absoluteStringWord: Constants.platformResource)

        // When
        let result = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<PlatformResponse>.self,
                endpoint: .savePlatform(id: nil, data: PlatformRequest(id: nil, name: name)))
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let platformName = dictionary.value(forKeyPath: "data.name") as? String
        XCTAssertEqual(platformName, name)
    }

    func testSaveExistingPlatform_ValidParameters_ShouldReturnValidPlatforms() async {
        // Given
        let id = "123"
        let name = "Plataforma Existente"
        let fakeJSONResponse = mock.fakeSaveExistingPlatformResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 201, absoluteStringWord: "/\(Constants.platformResource)?id=\(id)")

        // When
        let result = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<PlatformResponse>.self,
                endpoint: .savePlatform(id: id, data: PlatformRequest(id: id, name: name)))
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let platformName = dictionary.value(forKeyPath: "data.name") as? String
        XCTAssertEqual(platformName, name)
    }
}
