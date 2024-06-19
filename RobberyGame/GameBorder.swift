//
//  GameBorder.swift
//  PlayerMovement
//
//  Created by Michelle Angela Aryanto on 11/06/24.
//

import SpriteKit

class GameBorder : SKShapeNode {
    
    override init() {
        super.init()
        let thePath = CGMutablePath()
        let rect = CGRect(x: 0, y: 0, width: 640, height: 150)
        thePath.addRect(rect)
        path = thePath
        strokeColor = SKColor.white
        lineWidth = 4.0
        position = CGPoint(x: 0, y: 480)
        name = "bounds"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Used")
    }
}

// test
