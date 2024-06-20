//
//  Enemy.swift
//  PlayerMovement
//
//  Created by Michelle Angela Aryanto on 11/06/24.
//

import SpriteKit

class Enemy: SKShapeNode {

    // Store the size of the enemy shape
        var size: CGSize
        
        init(size: CGSize) {
            self.size = size
            super.init()
            
            // Create the shape using the provided size
            self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
            self.fillColor = SKColor.black // Adjust appearance as needed
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

