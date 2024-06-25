//
//  Player.swift
//  RobberyGame
//
//  Created by Medeline Agustine on 25/06/24.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    var playerName: String
    
    init(playerName: String, texture: SKTexture) {
        self.playerName = playerName
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
