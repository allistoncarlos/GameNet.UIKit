//
//  EditPlatformViewModelTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 14/04/22.
//

import XCTest
import GameNet_Network
import GameNet_Keychain
@testable import GameNet_UIKit

final class EditPlatformViewModelTests: XCTestCase {
    // MARK: - Properties
    let mock = PlatformsResponseMock()
    let stubRequests = StubRequests()
    var viewModel: EditPlatformViewModelProtocol?
    
    // MARK: - SetUp/TearDown
    override func setUp() {
        super.setUp()
        
        viewModel = EditPlatformViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        KeychainDataSource.clear()
    }
    
    // MARK: - Tests
    func testFetchPlatform_ShouldReturnValidData() async {
        // Given
        let id = "123"
        let fakeJSONResponse = mock.fakeSuccessPlatformResponse

        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: Constants.platformResource)

        // When
        await viewModel?.fetchData(id: id)
        let result = viewModel?.result

        // Then
        XCTAssertNotNil(result)

        let dictionary = fakeJSONResponse as NSDictionary
        let platform = dictionary.value(forKeyPath: "data") as? [String: Any?]
        let resultName = result?.name
        let expectedName = platform?["name"] as? String

        XCTAssertEqual(resultName, expectedName)
    }
    
    func testSaveNewPlatform_ValidParameters_ShouldReturnValidPlatform() async {
        // Given
        let name = "Nova Plataforma"
        let fakeJSONResponse = mock.fakeSaveNewPlatformResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 201, absoluteStringWord: Constants.platformResource)

        // When
        await viewModel?.save(id: nil, data: Platform(id: nil, name: name))
        let result = viewModel?.result
        
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
        await viewModel?.save(id: id, data: Platform(id: id, name: name))
        let result = viewModel?.result
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let platformName = dictionary.value(forKeyPath: "data.name") as? String
        XCTAssertEqual(platformName, name)
    }
}
