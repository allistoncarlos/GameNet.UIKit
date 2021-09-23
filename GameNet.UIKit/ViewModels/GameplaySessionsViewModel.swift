//
//  GameplaySessionsViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 22/09/21.
//

import Foundation

struct GameplaySessionsViewModel {
    var id: String?
    var totalGameplayTime: String
    var averageGameplayTime: String
    var sessions: [GameplaySessionViewModel]
}
