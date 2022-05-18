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
    
    let fakeSuccessPlatformsResponse: [String: Any?] = [
        "data": [
            "count": 2,
            "totalCount": 2,
            "totalPages": 1,
            "page": nil,
            "pageSize": nil,
            "search": "",
            "result": [
                [
                    "name": "Nintendo Switch",
                    "id": "123"
                ],
                [
                    "name": "PlayStation 5",
                    "id": "456"
                ]
            ]
        ],
        "ok": true,
        "errors": []
    ]
    
    let fakeSuccessGameResponse: [String: Any?] = [
        "data": [
            "userId": "123",
            "gameId": "123",
            "value": 0,
            "boughtDate": "2022-01-01T00:00:00Z",
            "have": true,
            "want": false,
            "digital": true,
            "original": true,
            "gameName": "The Legend of Zelda",
            "gameCoverURL": "https://placehold.co/600x400.jpg",
            "platformName": "Nintendo Switch",
            "platformId": "123",
            "gameplays": [
                [
                    "start": "2022-01-01T00:00:00Z",
                    "finish": "2022-01-01T00:00:00Z"
                ]
            ],
            "id": "123"
        ],
        "ok": true,
        "errors": []
    ]
    
    let fakeSuccessSaveGameResponse:  [String: Any?] = [
        "data": [
            "id": "123",
            "name": "The Legend of Zelda",
            "coverURL": "https://placehold.co/600x400.jpg",
            "platform": [
                "id": "123",
                "name": "Nintendo Switch"
            ]
        ],
        "ok": true,
        "errors": []
    ]
    
    let fakeSuccessSaveUserGameResponse:  [String: Any?] = [
        "data": [
            "id": "123",
            "userId": "123",
            "gameId": "123",
            "gameName": "The Legend of Zelda",
            "gameCoverURL": "https://placehold.co/600x400.jpg",
            "platformId": "123",
            "platformName": "Nintendo Switch"
        ],
        "ok": true,
        "errors": []
    ]
}
