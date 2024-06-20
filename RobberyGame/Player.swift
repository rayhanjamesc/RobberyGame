//
//  Player.swift
//  PlayerMovement
//
//  Created by Michelle Angela Aryanto on 11/06/24.
//

import SpriteKit

class Player : SKShapeNode {
    
    override init() {
        super.init()
        
        
        let thePath = CGMutablePath()
        thePath.move(to: CGPoint(x: 0, y: 0))
        thePath.addLine(to: CGPoint(x: 32, y: 0))
        thePath.addLine(to: CGPoint(x: 16, y: 32))
        thePath.closeSubpath()
        path = thePath
        strokeColor = SKColor.white
        lineWidth = 4.0
        position = CGPoint(x: 304, y: 4)
        name = "player"
        
        physicsBody = SKPhysicsBody(polygonFrom: thePath)
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Used")
    }
}
