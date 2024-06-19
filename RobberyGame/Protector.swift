//
//  Protector.swift
//  PlayerMovement
//
//  Created by Michelle Angela Aryanto on 13/06/24.
//

import SpriteKit

class Protector: SKShapeNode {

    // Store the size of the enemy shape
        var size: CGSize
        
        init(size: CGSize) {
            self.size = size
            super.init()
            
            // Create the shape using the provided size
            self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
            self.fillColor = SKColor.green // Adjust appearance as needed
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
