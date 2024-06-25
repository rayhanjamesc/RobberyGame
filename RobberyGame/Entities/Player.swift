//
//  Player.swift
//  RobberyGame
//
//  Created by Michelle Angela Aryanto on 25/06/24.
//

import SpriteKit

class Fox: SKSpriteNode {
    init() {
        // Load the image from your asset catalog
        let texture = SKTexture(imageNamed: "Fox_Idle_1") // Replace "Bear" with the name of your image asset
        let originalSize = texture.size()
        let scaledSize = CGSize(width: originalSize.width, height: originalSize.height)
        
        // Initialize the sprite node with the texture
        super.init(texture: texture, color: .clear, size: scaledSize)

        // Set up physics body
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody.isDynamic = false // Set to true if you want it to interact with other dynamic bodies
        self.physicsBody = physicsBody
        
        // Set other properties as needed
        name = "fox"
    }
    
    func idleState(){
        var textures: [SKTexture] = []
        for i in 1 ... 2 {
            let texture = SKTexture(imageNamed: "Fox_Idle_\(i)")
            textures.append(texture)
        }
        
        // Create the animation action
        let animation = SKAction.animate(with: textures, timePerFrame: 0.3)
        let repeatAction = SKAction.repeatForever(animation)
        
        self.removeAction(forKey: "walk")
        self.run(repeatAction)
    }
    
    func walkingState(){
        var textures: [SKTexture] = []
        for i in 1 ... 4 {
            let texture = SKTexture(imageNamed: "Fox_Walk_\(i)")
            textures.append(texture)
        }
        
        // Create the animation action
        let animation = SKAction.animate(with: textures, timePerFrame: 0.3)
        let repeatAction = SKAction.repeatForever(animation)

        // Remove any existing "idle" action and run the walk animation
        self.removeAction(forKey: "idle")
        self.run(repeatAction, withKey: "walk")
    }
    
    
    func flipPlayer(direction right: Bool) {
        if(right == true){
            self.xScale = -1.0
        } else {
            self.xScale = 1.0
        }
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FoxWalk: SKSpriteNode {
    init() {
        // Load the image from your asset catalog
        let texture = SKTexture(imageNamed: "Fox_Walk_1") // Replace "Bear" with the name of your image asset
        let originalSize = texture.size()
        let scaledSize = CGSize(width: originalSize.width, height: originalSize.height)
        
        // Initialize the sprite node with the texture
        super.init(texture: texture, color: .clear, size: scaledSize)
        
        // Set up physics body
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody.isDynamic = false // Set to true if you want it to interact with other dynamic bodies
        self.physicsBody = physicsBody
        
        // Set other properties as needed
        name = "fox_walk"

        
        
    }
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Cat: SKSpriteNode {
    init() {
        // Load the image from your asset catalog
        let texture = SKTexture(imageNamed: "cat") // Replace "Bear" with the name of your image asset
        let originalSize = texture.size()
        let scaledSize = CGSize(width: originalSize.width, height: originalSize.height)
        
        // Initialize the sprite node with the texture
        super.init(texture: texture, color: .clear, size: scaledSize)
        
        // Set up physics body
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody.isDynamic = false // Set to true if you want it to interact with other dynamic bodies
        self.physicsBody = physicsBody
        
        // Set other properties as needed
        name = "cat"
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


