//
//  PlatformsTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 12/04/22.
//

import XCTest
@testable import GameNet_UIKit

final class PlatformsTests: XCTestCase {
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
    func testPlatformsFetch_ValidParameters_ShouldReturnValidId() async {
        // Given
        let fakeJSONResponse = mock.fakeSuccessPlatformsResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: Constants.platformResource)
            
        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: APIResult<PagedResult<PlatformModel>>.self,
                endpoint: .platforms)
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.ok, true)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let platform = dictionary.value(forKeyPath: "data.result.@firstObject") as? [String: Any?]
        let resultName = result?.data.result[0].name
        let expectedName = platform?["name"] as? String
        XCTAssertEqual(resultName, expectedName)
    }
}
