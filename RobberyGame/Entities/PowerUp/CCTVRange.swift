//
//  CCTVRange.swift
//  RobberyGame
//
//  Created by Michelle Angela Aryanto on 24/06/24.
//

import SpriteKit
import GameplayKit
import GameKit

class CCTVRange: SKSpriteNode {
    init() {
        // Load the image from your asset catalog
        let texture = SKTexture(imageNamed: "cctv-triangle2") // Replace "Bear" with the name of your image asset
        let originalSize = texture.size()
        let scaledSize = CGSize(width: originalSize.width, height: originalSize.height)

        // Initialize the sprite node with the texture
        super.init(texture: texture, color: .clear, size: scaledSize)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        // Set up physics body
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody.isDynamic = false // Set to true if you want it to interact with other dynamic bodies
        
        self.physicsBody = physicsBody


        // Set other properties as needed
        name = "cctvRange"
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startMovementAnimation(turnRight clockwise: Bool) {
        let rotateDown: SKAction
        let rotateUp: SKAction

        if clockwise {
            rotateDown = SKAction.rotate(byAngle: -70 * .pi / 180, duration: 1.0)
            rotateUp = SKAction.rotate(byAngle: 70 * .pi / 180, duration: 1.0)
        } else {
            rotateDown = SKAction.rotate(byAngle: 70 * .pi / 180, duration: 1.0)
            rotateUp = SKAction.rotate(byAngle: -70 * .pi / 180, duration: 1.0)
        }

        let wait = SKAction.wait(forDuration: 0.5)
        let sequence = SKAction.sequence([rotateDown, wait, rotateUp])
        let repeatForever = SKAction.repeatForever(sequence)

        self.run(repeatForever)
    }
}
