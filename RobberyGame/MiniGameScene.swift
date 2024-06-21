//
//  MiniGameScene.swift
//  RobberyGame
//
//  Created by James Cellars on 20/06/24.
//

import Foundation
import SpriteKit

class MiniGameScene: SKScene {
    
    // Constants for pixel grid size and spacing
    let pixelSize: CGFloat = 10  // Size of each pixel
    let pixelSpacing: CGFloat = 1  // Spacing between pixels
    
    var selectedColor: UIColor = .red  // Initial color
    var colorButtons: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        setupImage()
        setupPixelArt()
        setupColorButtons()
    }
    
    func setupImage() {
        let art = SKSpriteNode(imageNamed: "Mario_Pixel")
        art.position = CGPoint(x: 0, y: 0)
        art.zPosition = -1
        addChild(art)
    }
    
    func setupPixelArt() {
        // Setup pixel art grid as before
        let numRows = 20
        let numColumns = 20
        
        let startX = frame.midX - CGFloat(numColumns) / 2 * (pixelSize + pixelSpacing)
        let startY = frame.midY - CGFloat(numRows) / 2 * (pixelSize + pixelSpacing)
        
        for row in 0..<numRows {
            for column in 0..<numColumns {
                let pixel = SKShapeNode(rectOf: CGSize(width: pixelSize, height: pixelSize))
                pixel.position = CGPoint(x: startX + CGFloat(column) * (pixelSize + pixelSpacing),
                                         y: startY + CGFloat(row) * (pixelSize + pixelSpacing))
                pixel.fillColor = .clear
                pixel.strokeColor = .black
                addChild(pixel)
            }
        }
    }
    
    func setupColorButtons() {
        let colors: [UIColor] = [.red, .blue, .green, .yellow, .purple]
        let buttonSize = CGSize(width: 40, height: 40)
        let startX = -frame.midX + buttonSize.width / 2 + 20 //Adjusts starting X position
        let startY = frame.maxY - buttonSize.height / 2 - 20 //Adjusts starting Y position
        
        for (index, color) in colors.enumerated() {
            let button = SKSpriteNode(color: color, size: buttonSize)
            button.position = CGPoint(x: startX + CGFloat(index) * (buttonSize.width + 10), y: -150)
            button.name = color.description // Set name to identify each button
            addChild(button)
            colorButtons.append(button)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        for button in colorButtons {
            if button.contains(touchLocation) {
                selectedColor = button.color
                print("Selected color")
                return
            }
        }
        
        if let pixelNode = self.atPoint(touchLocation) as? SKShapeNode {
            pixelNode.fillColor = selectedColor
        }
    }
}
