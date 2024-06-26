//
//  MiniGameScene.swift
//  RobberyGame
//
//  Created by James Cellars on 20/06/24.
//

import Foundation
import SpriteKit
import SwiftUI

class PixelNode: SKShapeNode {
    var row: Int = 0
    var column: Int = 0
}

class MiniGameScene: SKScene {
    
    // Constants for pixel grid size and spacing
    let pixelSize: CGFloat = 19.4 // Size of each pixel
    let pixelSpacing: CGFloat = 1  // Spacing between pixels
    let numRows = 28
    let numColumns = 20
    
    var referencePixels: [[SKColor]] = []
    var playerPixels: [[SKColor?]] = []
    
    let accuracyThreshold: Double = 70.0
    var isTracingSuccessful: Bool = false
    var accuracyLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: 1334, height: 750)
        self.scaleMode = .aspectFit
        
        setupImage()
        setupTrace()
        setupFinishButton()
        setupRetryButton()
        setupReference()
        setupGuide()
        setupBackButton()
        loadPixelProgress()
        displayResult()
        
        // Add back to map button
        let mapButton = UIButton(type: .custom)
        mapButton.setTitle("Back to map", for: .normal)
        mapButton.setTitleColor(.blue, for: .normal)
        mapButton.addTarget(self, action: #selector(mapButtonPressed), for: .touchUpInside)
        self.view?.addSubview(mapButton)
        mapButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        // Add retry button
//        let retryButton = SKLabelNode(fontNamed: "Helvetica")
//        retryButton.text = "Retry"
//        retryButton.fontSize = 24
//        retryButton.fontColor = SKColor.green
//        retryButton.position = CGPoint(x: 0, y: 50)
//        retryButton.name = "Retry"
//        addChild(retryButton)
        
        // Initialize and add accuracy label
        accuracyLabel = SKLabelNode(fontNamed: "Helvetica")
        accuracyLabel.fontSize = 30
        accuracyLabel.fontColor = SKColor.white
        accuracyLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height - 50)
        addChild(accuracyLabel)
        
        // Set the background color
        self.backgroundColor = UIColor(Color.theme.backgroundColor)
    }

    
    @objc func mapButtonPressed() {
        savePixelProgress()
        if let gameViewController = self.view?.window?.rootViewController as? GameViewController {
            if isTracingSuccessful {
                // gameViewController.transitionToEndGameScene()
            } else {
                gameViewController.transitionToGameScene()
            }
        }
    }
    
    func savePixelProgress() {
        var touchedPixels: [[Int]] = []
        for row in 0..<numRows {
            for column in 0..<numColumns {
                if let pixelColor = playerPixels[row][column], pixelColor != .clear {
                    let colorValue = pixelColor == .green ? 1 : 0 // 1 for green, 0 for red
                    touchedPixels.append([row, column, colorValue])
                }
            }
        }
        UserDefaults.standard.set(touchedPixels, forKey: "touchedPixels")
        print("Saved pixel data: \(touchedPixels)") // Debug print statement
    }


    
    func loadPixelProgress() {
        // Initialize playerPixels with .clear
        playerPixels = Array(repeating: Array(repeating: .clear, count: numColumns), count: numRows)
        
        if let savedPixels = UserDefaults.standard.array(forKey: "touchedPixels") as? [[Int]] {
            for pixel in savedPixels {
                if pixel.count == 3 { // Ensure the sub-array has exactly 3 elements
                    let row = pixel[0]
                    let column = pixel[1]
                    let colorValue = pixel[2]
                    let pixelColor: SKColor = (colorValue == 1) ? .green : .red

                    // Check if the row and column indices are within bounds
                    if row < numRows && column < numColumns {
                        playerPixels[row][column] = pixelColor

                        // Update the corresponding PixelNode
                        if let pixelNode = self.children.first(where: { node in
                            guard let pixelNode = node as? PixelNode else { return false }
                            return pixelNode.row == row && pixelNode.column == column
                        }) as? PixelNode {
                            pixelNode.fillColor = pixelColor
                        }
                    } else {
                        print("Invalid row or column index: (\(row), \(column))")
                    }
                } else {
                    print("Invalid pixel data: \(pixel)")
                }
            }
        } else {
            print("No saved pixel data found.")
        }
    }



    
    func resetMiniGame() {
        // Clear player pixels
        playerPixels = Array(repeating: Array(repeating: .clear, count: numColumns), count: numRows)
        
        // Clear pixel nodes
        for node in self.children {
            if let pixelNode = node as? PixelNode {
                pixelNode.fillColor = .clear
            }
        }
        
        isTracingSuccessful = false
    }
    
    func setupImage() {
        let art = SKSpriteNode(imageNamed: "MonalisaTracing")
        art.alpha = 0.4
        art.setScale(1.67)
        art.position = CGPoint(x: size.width / 2, y: size.height / 2 - 1)
        art.zPosition = -1
        addChild(art)
    }
    
    func setupGuide() {
        let guide = SKSpriteNode(imageNamed: "MonalisaGuide")
        guide.setScale(2)
        guide.position = CGPoint(x: 160, y: size.height / 4 + 40)
        guide.zPosition = -1
        addChild(guide)
    }
    
    func setupReference() {
        referencePixels = Array(repeating: Array(repeating: .clear, count: numColumns), count: numRows)
        
        let markedCoordinates = [
            (25, 9), (25, 10), (25, 11),
            (24, 8), (24, 12), (24, 13),
            (23, 7), (23, 14),
            (22, 6), (22, 14),
            (21, 6), (21, 15),
            (20, 6), (20, 15),
            (19, 6), (19, 15),
            (18, 6), (18, 15),
            (17, 7), (17, 15),
            (16, 7), (16, 15),
            (15, 6), (15, 16),
            (14, 5), (14, 17),
            (13, 4), (13, 18),
            (12, 3), (12, 18),
            (11, 3), (11, 18),
            (10, 2), (10, 18),
            (9, 1), (9, 18),
            (8, 1), (8, 19),
            (7, 1),
            (6, 0)
        ]
        
        for (row, column) in markedCoordinates {
            referencePixels[row][column] = .black // or any other color you want to mark
        }
    }
    
    func setupTrace() {
        let startX = frame.midX - CGFloat(numColumns) / 2 * (pixelSize + pixelSpacing)
        let startY = frame.midY - CGFloat(numRows) / 2 * (pixelSize + pixelSpacing)
        
        for row in 0..<numRows {
            var rowArray: [SKColor?] = []
            for column in 0..<numColumns {
                let trace = PixelNode(rectOf: CGSize(width: pixelSize, height: pixelSize))
                
                // Set row and column properties
                trace.row = row
                trace.column = column
                
                trace.position = CGPoint(x: 242 + startX / 2 + CGFloat(column) * (pixelSize + pixelSpacing),
                                         y: 9.6 + startY + CGFloat(row) * (pixelSize + pixelSpacing))
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
        colorPixel(at: touchLocation)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        colorPixel(at: touchLocation)
    }

    
    func colorPixel(at location: CGPoint) {
        if let pixelNode = self.atPoint(location) as? PixelNode {
            if referencePixels[pixelNode.row][pixelNode.column] != .clear {
                pixelNode.fillColor = .green
                playerPixels[pixelNode.row][pixelNode.column] = .green
            } else {
                pixelNode.fillColor = .red
                playerPixels[pixelNode.row][pixelNode.column] = .red
            }
        }
    }


    
    func calculateAccuracy() -> Double {
        let markedCoordinates = [
            (25, 9), (25, 10), (25, 11),
            (24, 8), (24, 12), (24, 13),
            (23, 7), (23, 14),
            (22, 6), (22, 14),
            (21, 6), (21, 15),
            (20, 6), (20, 15),
            (19, 6), (19, 15),
            (18, 6), (18, 15),
            (17, 7), (17, 15),
            (16, 7), (16, 15),
            (15, 6), (15, 16),
            (14, 5), (14, 17),
            (13, 4), (13, 18),
            (12, 3), (12, 18),
            (11, 3), (11, 18),
            (10, 2), (10, 18),
            (9, 1), (9, 18),
            (8, 1), (8, 19),
            (7, 1),
            (6, 0)
        ]
        
        var correctCount = 0
        var wrongCount = 0
        var inputCount = 0
        let totalMarkedCoordinates = markedCoordinates.count
        
        // Create a set of marked coordinates for quick lookup
        let markedCoordinatesSet = Set(markedCoordinates.map { "\($0.0),\($0.1)" })
        
        for row in 0..<numRows {
            for column in 0..<numColumns {
                let coordinateString = "\(row),\(column)"
                if let playerColor = playerPixels[row][column] {
                    if playerColor == .green {
                        correctCount += 1
                        inputCount += 1
                    } else if playerColor == .red {
                        wrongCount += 1
                        inputCount += 1
                    }
                }
            }
        }
        print(correctCount, wrongCount, inputCount)
        
        // Ensure the correct count is not less than zero
        correctCount = max(correctCount, 0)
        let errorScore = (Double(wrongCount) / Double(inputCount)) * 100
        let correctScore = (Double(correctCount) / Double(totalMarkedCoordinates)) * 100
        let finalCount = correctScore - errorScore
        print(correctScore, errorScore, finalCount)
        let accuracy = totalMarkedCoordinates > 0 ? finalCount : 0
        var roundedAccuracy = round(accuracy)
        if roundedAccuracy < 0 {
            roundedAccuracy = 0
        }
        print(roundedAccuracy)
        
        // Update the accuracy label
        accuracyLabel.text = "Accuracy: \(Int(roundedAccuracy))%"
        
        return roundedAccuracy
    }
    
    func setupFinishButton() {
//        let finishButton = SKLabelNode(text: "Finish")
//        finishButton.fontSize = 30
//        finishButton.fontColor = .green
//        finishButton.position = CGPoint(x: 800, y: size.height / 2)
//        finishButton.name = "finishButton"
//        addChild(finishButton)
        
        //Add finish button
        let finishButton = UIButton(type: .custom)
        finishButton.accessibilityIdentifier = "finishButton"
//        finishButton.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
        self.view?.addSubview(finishButton)
        finishButton.frame = CGRect(x: 600, y: 270, width: 150, height: 100)
        
//        electricButton.isHidden = true
        
        //Set image for trace button
        if let buttonImage = UIImage(named: "FinishButton-Default.svg") {
            finishButton.setImage(buttonImage, for: .normal)
        }
    
//        finishButton.position = CGPoint(x: 900, y: size.height / 2)
        finishButton.layer.zPosition = 3
//        finishButton.addTarget(self, action: #selector(traceButtonPressed), for: .touchUpInside)
    }
    
    // setup retry button
    func setupRetryButton() {
        let retryButton = UIButton(type: .custom)
        retryButton.accessibilityIdentifier = "retryButton"
        retryButton.frame = CGRect(x: 200, y: 25, width: 150, height: 100)
        
        if let buttonImage = UIImage(named: "RetryButton") { // Use a supported image format
            retryButton.setImage(buttonImage, for: .normal)
        }
        
        retryButton.imageView?.contentMode = .scaleAspectFit
        retryButton.layer.zPosition = 3
//        retryButton.isHidden = true // Initially hidden
//        retryButton.addTarget(self, action: #selector(retryButtonPressed), for: .touchUpInside)
        
        self.view?.addSubview(retryButton)
    }
    
    func setupBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.accessibilityIdentifier = "backButton"
        backButton.frame = CGRect(x: 50, y: 25, width: 150, height: 100)
        
        if let buttonImage = UIImage(named: "BackButton") { // Use a supported image format
            backButton.setImage(buttonImage, for: .normal)
        }
        
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.layer.zPosition = 3
//        retryButton.isHidden = true // Initially hidden
//        retryButton.addTarget(self, action: #selector(retryButtonPressed), for: .touchUpInside)
        
        self.view?.addSubview(backButton)
    }
    
    func displayResult() {
        let winTexture = SKTexture(imageNamed: "escape_png") // Use the name of your image file
            let winNode = SKSpriteNode(texture: winTexture)

            
            // Set the position of the result node to the center of the screen
            winNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
            
            // Optionally, you can set the scale of the result node
            winNode.setScale(0.8) // Adjust the scale as needed
            
            // Add the result node to the scene
            addChild(winNode)
        
        
//        let loseTexture = SKTexture(imageNamed: "lose_png") // Use the name of your image file
//            let loseNode = SKSpriteNode(texture: loseTexture)
//
//            
//            // Set the position of the result node to the center of the screen
//            loseNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
//            
//            // Optionally, you can set the scale of the result node
//            loseNode.setScale(0.8) // Adjust the scale as needed
//            
//            // Add the result node to the scene
//            addChild(loseNode)
    }

    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if let finishButton = self.atPoint(touchLocation) as? SKLabelNode, finishButton.name == "finishButton" {
            let accuracy = calculateAccuracy()
            print("Accuracy: \(accuracy)%")
            
            if accuracy < accuracyThreshold {
                // Shows retry button if accuracy is below threshold
                if let retryButton = self.view?.subviews.first(where: { $0 is UIButton && ($0 as! UIButton).title(for: .normal) == "Retry"}) {
                    retryButton.isHidden = false
                }
            }
        } else if let retryButton = self.atPoint(touchLocation) as? SKLabelNode, retryButton.name == "Retry" {
            // Handle retry button click
            resetMiniGame()
        }
    }
}
