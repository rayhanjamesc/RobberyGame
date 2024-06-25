//
//  GuardTrack.swift
//  RobberyGame
//
//  Created by Michelle Angela Aryanto on 24/06/24.
//

import SpriteKit

class GuardTrack: SKNode {
    override init() {
        super.init()

        let bear = Bear()
        bear.setScale(2)
                    
        self.addChild(bear)
        
        let moveRight = SKAction.moveBy(x: 500, y: 2, duration: 4)
        let moveUp = SKAction.moveBy(x: 0, y: 250, duration: 3)
        let moveLeft = SKAction.moveBy(x: -500, y: 2, duration: 4)
        let moveDown = SKAction.moveBy(x: 0, y: -250, duration: 3)
        
        let flipHorizontallyRight = SKAction.run { bear.xScale = -2.0 }
        let flipHorizontallyLeft = SKAction.run { bear.xScale = 2.0 }
        
         
        // Create a sequence of actions with flipping included
        let sequence = SKAction.sequence([
            moveLeft,
            moveUp,
            flipHorizontallyRight,
            moveRight,
            moveDown,
            flipHorizontallyLeft
        ])
        
        let repeatForever = SKAction.repeatForever(sequence)
        bear.run(repeatForever)


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

