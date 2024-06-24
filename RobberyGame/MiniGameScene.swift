//
//  MiniGameScene.swift
//  RobberyGame
//
//  Created by James Cellars on 20/06/24.
//

import Foundation
import SpriteKit

class PixelNode: SKShapeNode {
    var row: Int = 0
    var column: Int = 0
}

class MiniGameScene: SKScene {
    
    //Constants for pixel grid size and spacing
    let pixelSize: CGFloat = 10  // Size of each pixel
    let pixelSpacing: CGFloat = 1  // Spacing between pixels
    let numRows = 20
    let numColumns = 20
    
    var referencePixels: [[SKColor]] = []
    var playerPixels: [[SKColor?]] = []
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: 1334, height: 750)
        self.scaleMode = .aspectFit
        
        setupImage()
        setupTrace()
        setupFinishButton()
        setupReference()
        
        //Add back to map button
        let mapButton = UIButton(type: .custom)
        mapButton.setTitle("Back to map", for: .normal)
        mapButton.setTitleColor(.blue, for: .normal)
        mapButton.addTarget(self, action: #selector(mapButtonPressed), for: .touchUpInside)
        self.view?.addSubview(mapButton)
        mapButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    @objc func mapButtonPressed() {
        if let gameViewController = self.view?.window?.rootViewController as? GameViewController {
            gameViewController.transitionToGameScene()
        }
    }
    
    func setupImage() {
        let art = SKSpriteNode(imageNamed: "Mario_Pixel")
        art.position = CGPoint(x: size.width / 2, y: size.height / 2)
        art.zPosition = -1
        addChild(art)
    }
    
    func setupReference() {
        referencePixels = Array(repeating: Array(repeating: .clear, count: numColumns), count: numRows)
    }
    
    func setupTrace() {
        let startX = frame.midX - CGFloat(numColumns) / 2 * (pixelSize + pixelSpacing)
        let startY = frame.midY - CGFloat(numRows) / 2 * (pixelSize + pixelSpacing)
        
        for row in 0..<numRows {
            var rowArray: [SKColor?] = []
            for column in 0..<numColumns {
                let trace = PixelNode(rectOf: CGSize(width: pixelSize, height: pixelSize))
                
                //Set row and column properties
                trace.row = row
                trace.column = column
                
                trace.position = CGPoint(x: startX + CGFloat(column) * (pixelSize + pixelSpacing),
                                         y: startY + CGFloat(row) * (pixelSize + pixelSpacing))
                trace.fillColor = .clear
                trace.strokeColor = .black
                addChild(trace)
                
                rowArray.append(.clear)
            }
            playerPixels.append(rowArray)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if let pixelNode = self.atPoint(touchLocation) as? PixelNode {
            pixelNode.fillColor = .red
            playerPixels[pixelNode.row][pixelNode.column] = .red
        } else if let finishButton = self.atPoint(touchLocation) as? SKLabelNode, finishButton.name == "finishButton" {
            let accuracy = calculateAccuracy()
            print("Accuracy: \(accuracy)%")
        }
    }
    
    func calculateAccuracy() -> Double {
        var correctPixels = 0
        var totalPixels = 0
        
        for row in 0..<numRows {
            for column in 0..<numColumns {
                totalPixels += 1
                if let playerColor = playerPixels[row][column], playerColor == referencePixels[row][column] {
                    correctPixels += 1
                }
            }
        }
        
        return totalPixels > 0 ? (Double(correctPixels) / Double(totalPixels)) * 100 : 0
    }
    
    func setupFinishButton() {
        let finishButton = SKLabelNode(text: "Finish")
        finishButton.fontSize = 30
        finishButton.fontColor = .green
        finishButton.position = CGPoint(x: 300, y: size.height / 2)
        finishButton.name = "finishButton"
        addChild(finishButton)
    }
}
