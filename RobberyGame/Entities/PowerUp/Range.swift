//
//  Range.swift
//  RobberyGame
//
//  Created by Michelle Angela Aryanto on 24/06/24.
//

import SpriteKit

class ConeShape: SKShapeNode {
    override init() {
        super.init()
            
        // Define the points of the cone shape
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 100, y: 50)) // Adjust length and width as needed
        path.addLine(to: CGPoint(x: 0, y: 100))
        path.closeSubpath()
            
        // Set the path and other properties
        self.path = path
        fillColor = SKColor.red.withAlphaComponent(0.5) // Adjust color and opacity as needed
        strokeColor = SKColor.clear
        
        // Add physics body with the same shape
        let physicsBody = SKPhysicsBody(polygonFrom: path)
        physicsBody.isDynamic = false // Set to true if you want it to interact with other dynamic bodies
        self.physicsBody = physicsBody
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
