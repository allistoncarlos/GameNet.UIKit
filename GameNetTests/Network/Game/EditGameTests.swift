//
//  EditGameTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 18/05/22.
//

import Foundation
import XCTest
@testable import GameNet_UIKit

final class EditGameTests: XCTestCase {
    // MARK: - Properties
    let mock = GamesResponseMock()
    let stubRequests = StubRequests()
    
    // MARK: - SetUp/TearDown
    override func tearDown() {
        super.tearDown()
        KeychainDataSource.clear()
        URLCache.shared.removeAllCachedResponses()
    }
    
    // MARK: - Tests
    func testGameFetch_ValidParameters_ShouldReturnValidData() async {
        // Given
        let gameId = "123"
        let absoluteStringWord = "\(Constants.gameResource)/\(gameId)"
        let fakeJSONResponse = mock.fakeSuccessGameResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: absoluteStringWord)
        
        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: APIResult<GameDetailModel>.self,
                endpoint: .game(id: gameId))
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.ok, true)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let game = dictionary.value(forKeyPath: "data") as? [String: Any?]
        let resultName = result?.data.name
        let expectedName = game?["gameName"] as? String
        XCTAssertEqual(resultName, expectedName)
        
        let resultStartDate = result?.data.gameplays?[0].start
        let gameplay = dictionary.value(forKeyPath: "data.gameplays.@firstObject") as? NSDictionary
        let expectedStartDate = gameplay?.value(forKeyPath: "start") as! String
        
        XCTAssertEqual(resultStartDate, expectedStartDate.toDate())
    }
}
