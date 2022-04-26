//
//  GamesResponseMock.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 20/04/22.
//

import Foundation

final class GamesResponseMock {
    let fakeSuccessGamesPagedResponse: [String: Any?] = [
        "data": [
            "count": 3,
            "totalCount": 3,
            "totalPages": 1,
            "page": 0,
            "pageSize": 21,
            "search": nil,
            "result": [
                [
                    "userId": "123",
                    "gameId": "123",
                    "gameName": "Doki-Doki Universe",
                    "gameCoverURL": "https://placehold.co/600x400.jpg",
                    "platformId": "123",
                    "platformName": "PlayStation 4",
                    "id": "123"
                ],
                [
                    "userId": "123",
                    "gameId": "123",
                    "gameName": "Mercenary Kings",
                    "gameCoverURL": "https://placehold.co/600x400.jpg",
                    "platformId": "123",
                    "platformName": "PlayStation 4",
                    "id": "123"
                ],
                [
                    "userId": "123",
                    "gameId": "123",
                    "gameName": "Resogun",
                    "gameCoverURL": "https://placehold.co/600x400.jpg",
                    "platformId": "123",
                    "platformName": "PlayStation 4",
                    "id": "123"
                ]
            ]
        ],
        "ok": true,
        "errors": []
    ]
    
    let fakeSuccessGamesPagedSearchResponse: [String: Any?] = [
        "data": [
            "count": 3,
            "totalCount": 3,
            "totalPages": 1,
            "page": 0,
            "pageSize": 21,
            "search": "zelda",
            "result": [
                [
                    "userId": "123",
                    "gameId": "123",
                    "gameName": "The Legend of Zelda",
                    "gameCoverURL": "https://placehold.co/600x400.jpg",
                    "platformId": "123",
                    "platformName": "Nintendo 3DS (Virtual Console)",
                    "id": "123"
                ],
                [
                    "userId": "123",
                    "gameId": "123",
                    "gameName": "The Legend of Zelda: A Link Between Worlds",
                    "gameCoverURL": "https://placehold.co/600x400.jpg",
                    "platformId": "123",
                    "platformName": "Nintendo 3DS",
                    "id": "123"
                ],
                [
                    "userId": "123",
                    "gameId": "123",
                    "gameName": "The Legend of Zelda: Majoras Mask",
                    "gameCoverURL": "https://placehold.co/600x400.jpg",
                    "platformId": "123",
                    "platformName": "Nintendo Wii (Virtual Console)",
                    "id": "123"
                ]
            ]
        ],
        "ok": true,
        "errors": []
    ]
}
