//
//  CCTVRange.swift
//  RobberyGame
//
//  Created by Michelle Angela Aryanto on 24/06/24.
//

import SpriteKit

class CCTVRange: SKSpriteNode {
    init() {
        // Load the image from your asset catalog
        let texture = SKTexture(imageNamed: "cctv-triangle") // Replace "Bear" with the name of your image asset
        let originalSize = texture.size()
        let scaledSize = CGSize(width: originalSize.width, height: originalSize.height)
        
        // Initialize the sprite node with the texture
        super.init(texture: texture, color: .clear, size: scaledSize)
        self.anchorPoint = CGPoint(x: 0.5, y: 1.0)

        
        // Set up physics body
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody.isDynamic = false // Set to true if you want it to interact with other dynamic bodies
        self.physicsBody = physicsBody
        
        // Set other properties as needed
        name = "enemyBear"
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMovementAnimation() {
        let rotateDown = SKAction.rotate(byAngle: 70 * .pi / 180, duration: 1.0)
        let rotateUp = SKAction.rotate(byAngle: -70 * .pi / 180, duration: 1.0)
        let wait = SKAction.wait(forDuration: 0.5)
        let sequence = SKAction.sequence([rotateDown, wait, rotateUp])
        let repeatForever = SKAction.repeatForever(sequence)

        self.run(repeatForever)
    }
}



//class CCTVRange: SKShapeNode {
//    override init() {
//        super.init()
//            
//        // Define the points of the cone shape
//        let path = CGMutablePath()
//        path.move(to: CGPoint(x: 0, y: 250))
//        path.addLine(to: CGPoint(x: -80, y: 0))
//        path.addLine(to: CGPoint(x: 80, y: 0))
//        path.closeSubpath()
//            
//        // Set the path and other properties
//        self.path = path
//        fillColor = SKColor.red.withAlphaComponent(0.5) // Adjust color and opacity as needed
//        strokeColor = SKColor.clear
//        
//        // Set the anchor point to the top of the triangle
//        self.position = CGPoint(x: 0, y: -250)
//        self.scene?.anchorPoint = CGPoint(x: 0, y: -250)
//
//        // Add physics body with the same shape
//        let physicsBody = SKPhysicsBody(polygonFrom: path)
//        physicsBody.isDynamic = false // Set to true if you want it to interact with other dynamic bodies
//        self.physicsBody = physicsBody
//    }
//    
//    @available(*, unavailable)
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func startMovementAnimation() {
//        self.scene?.anchorPoint = CGPoint(x: 0.5, y: 1.0)
//        let rotateDown = SKAction.rotate(byAngle: CGFloat.pi / 2, duration: 1.0)
//        let rotateUp = SKAction.rotate(byAngle: -CGFloat.pi / 2, duration: 1.0)
//        let wait = SKAction.wait(forDuration: 0.5)
//        let sequence = SKAction.sequence([rotateDown, wait, rotateUp])
//        let repeatForever = SKAction.repeatForever(sequence)
//
//        self.run(repeatForever)
//    }
//}
