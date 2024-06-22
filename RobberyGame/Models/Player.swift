//
//  Player.swift
//  RobberyGame
//
//  Created by Medeline Agustine on 21/06/24.
//

import Foundation
import UIKit

struct Player: Codable {
    var displayName: String
    //var status: PlayerStatus = .idle
    //var life: Float = 100
}

enum PlayerType: String, Codable, CaseIterable {
    case one
    case two
}

extension PlayerType{
    
}
