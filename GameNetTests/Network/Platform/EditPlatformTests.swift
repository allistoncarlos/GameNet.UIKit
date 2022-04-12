//
//  EditPlatformTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 12/04/22.
//

import XCTest
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
    func testSaveNewPlatform_ValidParameters_ShouldReturnValidPlatforms() async {
        // Given
        let name = "Nova Plataforma"
        let fakeJSONResponse = mock.fakeSaveNewPlatformResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 201, absoluteStringWord: "gamenet.azurewebsites.net")

        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: APIResult<PlatformModel>.self,
                endpoint: .savePlatform(id: nil, model: PlatformModel(id: nil, name: name)),
                cache: false)
        
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
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 201, absoluteStringWord: "gamenet.azurewebsites.net")

        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: APIResult<PlatformModel>.self,
                endpoint: .savePlatform(id: id, model: PlatformModel(id: id, name: name)),
                cache: false)
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let platformName = dictionary.value(forKeyPath: "data.name") as? String
        XCTAssertEqual(platformName, name)
    }
}
