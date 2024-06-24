//
//  CCTV.swift
//  RobberyGame
//
//  Created by Michelle Angela Aryanto on 24/06/24.
//

import SpriteKit

class CCTV: SKSpriteNode {
    init() {
        // Load the image from your asset catalog
        let texture = SKTexture(imageNamed: "cctv-top")
        let originalSize = texture.size()
        let scaledSize = CGSize(width: originalSize.width, height: originalSize.height)
        
        // Initialize the sprite node with the texture
        super.init(texture: texture, color: .clear, size: scaledSize)
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        // Set up physics body
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody.isDynamic = true // Set to true if you want it to interact with other dynamic bodies
        self.physicsBody = physicsBody
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = 0

        // Set other properties as needed
        name = "cctv"
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
