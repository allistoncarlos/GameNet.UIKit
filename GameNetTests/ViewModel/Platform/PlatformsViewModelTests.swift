//
//  PlatformsViewModelTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 14/04/22.
//

import XCTest
@testable import GameNet_UIKit

final class PlatformsViewModelTests: XCTestCase {
    // MARK: - Properties
    let mock = PlatformsResponseMock()
    let stubRequests = StubRequests()
    var viewModel: PlatformsViewModelProtocol?
    
    // MARK: - SetUp/TearDown
    override func setUp() {
        super.setUp()
        
        viewModel = PlatformsViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        KeychainDataSource.clear()
    }
    
    // MARK: - Tests
    func testFetchPlatforms_ShouldReturnValidData() async {
        // Given
        let fakeJSONResponse = mock.fakeSuccessPlatformsResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: Constants.platformResource)
        
        // When
        await viewModel?.fetchData()
        let result = viewModel?.result
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let platform = dictionary.value(forKeyPath: "data.result.@firstObject") as? [String: Any?]
        let resultName = result?[0].name
        let expectedName = platform?["name"] as? String
        
        XCTAssertEqual(resultName, expectedName)
    }
}
