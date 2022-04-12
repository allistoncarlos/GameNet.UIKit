//
//  EditListTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 12/04/22.
//

import XCTest
@testable import GameNet_UIKit

final class EditListTests: XCTestCase {
    // MARK: - Properties
    let mock = ListResponseMock()
    let stubRequests = StubRequests()
    
    // MARK: - SetUp/TearDown
    override func tearDown() {
        super.tearDown()
        KeychainDataSource.clear()
        URLCache.shared.removeAllCachedResponses()
    }
    
    // MARK: - Tests
//    func testFinishedByYearListFetch_ValidParameters_ShouldReturnValidGames() async {
//        // Given
//        let year = "2022"
//        let fakeJSONResponse = mock.fakeFinishedByYearResponse
//
//        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
//
//        // When
//        let result = await NetworkManager.shared
//            .performRequest(
//                model: APIResult<[ListItemModel]>.self,
//                endpoint: .finishedByYearList(id: year),
//                cache: false)
//
//        // Then
//        XCTAssertNotNil(result)
//        XCTAssertEqual(result?.ok, true)
//
//        let dictionary = fakeJSONResponse as NSDictionary
//        let list = dictionary.value(forKeyPath: "data.@firstObject") as? [String: Any?]
//        let expectedName = list?["gameName"] as? String
//
//        XCTAssertEqual(result?.data[0].name, expectedName)
//    }
//
//    func testBoughtByYearListFetch_ValidParameters_ShouldReturnValidGames() async {
//        // Given
//        let year = "2022"
//        let fakeJSONResponse = mock.fakeBoughtByYearResponse
//
//        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
//
//        // When
//        let result = await NetworkManager.shared
//            .performRequest(
//                model: APIResult<[ListItemModel]>.self,
//                endpoint: .boughtByYearList(id: year),
//                cache: false)
//
//        // Then
//        XCTAssertNotNil(result)
//        XCTAssertEqual(result?.ok, true)
//
//        let dictionary = fakeJSONResponse as NSDictionary
//        let list = dictionary.value(forKeyPath: "data.@firstObject") as? [String: Any?]
//        let expectedName = list?["gameName"] as? String
//
//        XCTAssertEqual(result?.data[0].name, expectedName)
//    }
//
//    func testListFetch_ValidParameters_ShouldReturnValidList() async {
//        // Given
//        let id = "123"
//        let fakeJSONResponse = mock.fakeListSuccessResponse
//        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
//
//        // When
//        let result = await NetworkManager.shared
//            .performRequest(
//                model: APIResult<ListGameModel>.self,
//                endpoint: .list(id: id),
//                cache: false)
//
//        // Then
//        XCTAssertNotNil(result)
//        XCTAssertEqual(result?.ok, true)
//
//        let dictionary = fakeJSONResponse as NSDictionary
//        XCTAssertEqual(result?.data.name, dictionary.value(forKeyPath: "data.name") as? String)
//    }
}
