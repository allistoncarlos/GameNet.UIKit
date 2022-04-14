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
    func testFetchPlatform_ShouldReturnValidData() async {
        // Given
        let id = "123"
        let fakeJSONResponse = mock.fakeListSuccessResponse

        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: Constants.listResource)

        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: APIResult<ListModel>.self,
                endpoint: .list(id: id))

        // Then
        XCTAssertNotNil(result)

        let dictionary = fakeJSONResponse as NSDictionary
        let list = dictionary.value(forKeyPath: "data") as? [String: Any?]
        let resultName = result?.data.name
        let expectedName = list?["name"] as? String

        XCTAssertEqual(resultName, expectedName)
    }
    
    func testSaveNewList_ValidParameters_ShouldReturnValidLists() async {
        // Given
        let name = "Nova Lista"
        let userId = "123"
        let fakeJSONResponse = mock.fakeSaveNewListResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 201, absoluteStringWord: Constants.listResource)

        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: APIResult<ListModel>.self,
                endpoint: .saveList(id: nil, model: ListModel(id: nil, name: name, userId: userId, creationDate: .now)))
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let listName = dictionary.value(forKeyPath: "data.name") as? String
        XCTAssertEqual(listName, name)
    }

    func testSaveExistingPlatform_ValidParameters_ShouldReturnValidPlatforms() async {
        // Given
        let id = "123"
        let userId = "123"
        let name = "Plataforma Existente"
        let fakeJSONResponse = mock.fakeSaveExistingListResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 201, absoluteStringWord: "/\(Constants.listResource)?id=\(id)")

        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: APIResult<ListModel>.self,
                endpoint: .saveList(id: id, model: ListModel(id: id, name: name, userId: userId, creationDate: .now)))
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let listName = dictionary.value(forKeyPath: "data.name") as? String
        XCTAssertEqual(listName, name)
    }
}
