//
//  ListResponseMock.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 11/04/22.
//

import Foundation

final class ListResponseMock {
    let fakeFinishedByYearResponse: [String: Any?] = [
        "data": [
            [
                "year": 2022,
                "userGameId": "123",
                "gameName": "Marvel Spider-Man: Miles Morales",
                "platformName": "PlayStation 4",
                "cover": "https://placehold.co/600x400.jpg",
                "start": "2021-12-29T15:38:55Z",
                "finish": "2022-01-30T20:29:43Z",
                "id": nil
            ],
            [
                "year": 2022,
                "userGameId": "456",
                "gameName": "Disney's Aladdin",
                "platformName": "Super Nintendo",
                "cover": "https://placehold.co/600x400.jpg",
                "start": "2022-03-31T16:24:18Z",
                "finish": "2022-04-06T16:34:42Z",
                "id": nil
            ]
        ],
        "ok": true,
        "errors": []
    ]
    
    let fakeBoughtByYearResponse: [String: Any?] = [
        "data": [
            [
                "year": 2022,
                "userGameId": "123",
                "gameName": "Mario Kart 8 Deluxe",
                "platformName": "Nintendo Switch",
                "cover": "https://placehold.co/600x400.jpg",
                "boughtDate": "2022-03-07T13:07:43Z",
                "value": 200.33,
                "id": nil
            ],
            [
                "year": 2022,
                "userGameId": "456",
                "gameName": "Horizon: Forbidden West",
                "platformName": "PlayStation 4",
                "cover": "https://placehold.co/600x400.jpg",
                "boughtDate": "2022-02-18T17:48:52Z",
                "value": 0,
                "id": nil
            ]
        ],
        "ok": true,
        "errors": []
    ]
    
    let fakeListSuccessResponse: [String: Any?] = [
        "data": [
            "name": "Próximos à Jogar",
            "creationDate": "2020-05-19T00:00:00Z",
            "games": [
                [
                    "userId": "123",
                    "userGameId": "123",
                    "listId": "123",
                    "gameName": "My Hero One's Justice 2",
                    "platformName": "PlayStation 4",
                    "cover": "https://placehold.co/600x400.jpg",
                    "order": 1,
                    "comment": "Próximos à Jogar - My Hero One's Justice 2"
                ],
                [
                    "userId": "123",
                    "userGameId": "456",
                    "listId": "123",
                    "gameName": "Fantasian",
                    "platformName": "Apple Arcade",
                    "cover": "https://placehold.co/600x400.jpg",
                    "order": 2,
                    "comment": "Próximos à Jogar - Fantasian"
                ],
                [
                    "userId": "123",
                    "userGameId": "789",
                    "listId": "123",
                    "gameName": "Lords of Waterdeep",
                    "platformName": "PC",
                    "cover": "https://placehold.co/600x400.jpg",
                    "order": 3,
                    "comment": "Próximos à Jogar - Lords of Waterdeep"
                ],
                [
                    "userId": "123",
                    "userGameId": "012",
                    "listId": "123",
                    "gameName": "The Legend of Zelda: Wind Waker HD",
                    "platformName": "Nintendo WiiU",
                    "cover": "https://placehold.co/600x400.jpg",
                    "order": 4,
                    "comment": "Próximos à Jogar - Wind Waker HD"
                ]
            ],
            "id": "123"
        ],
        "ok": true,
        "errors": []
    ]
    
    let fakeSaveNewListResponse: [String: Any?] = [
        "data": [
            "name": "Nova Lista",
            "userId": "123"
        ],
        "ok": true,
        "errors": []
    ]
    
    let fakeSaveExistingListResponse: [String: Any?] = [
        "data": [
            "name": "Plataforma Existente",
            "userId": "123"
        ],
        "ok": true,
        "errors": []
    ]
}
