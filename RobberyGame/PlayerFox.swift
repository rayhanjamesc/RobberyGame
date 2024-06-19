//
//  PlayerFox.swift
//  PlayerMovement
//
//  Created by Michelle Angela Aryanto on 11/06/24.
//

import SpriteKit

class PlayerFox: SKSpriteNode {
    
    init() {
        // Load the image from your asset catalog
        let texture = SKTexture(imageNamed: "fox") // Replace "playerImage" with the name of your image asset
        let desiredSize = CGSize(width: 100, height: 100) // Adjust as needed

        
        // Initialize the sprite node with the texture
        super.init(texture: texture, color: .clear, size: desiredSize)
        
        // Set up physics body if needed
        physicsBody = SKPhysicsBody(texture: texture, size: desiredSize)
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        
        // Set other properties as needed
        name = "playerFox"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

