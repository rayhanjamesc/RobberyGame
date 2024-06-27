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
    
    //Buttons for variables
    let retryButton = UIButton(type: .custom)
    let backButton = UIButton(type: .custom)
    let finishButton = UIButton(type: .custom)
    
    var referencePixels: [[SKColor]] = []
    var playerPixels: [[SKColor?]] = []
    
    let accuracyThreshold: Double = 70.0
    var isTracingSuccessful: Bool = false
    var accuracyLabel: SKLabelNode!
    
    var artNode: SKSpriteNode!
    var resultNode: SKSpriteNode?
    
    var canExit = false
    
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
        
        // Initialize and add accuracy label
        accuracyLabel = SKLabelNode(fontNamed: "Helvetica")
        accuracyLabel.fontSize = 30
        accuracyLabel.fontColor = SKColor.white
        accuracyLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height - 50)
        addChild(accuracyLabel)

    }
    
    @objc func retryButtonPressed() {
        resetMiniGame()
        resultNode?.removeFromParent()
        resultNode = nil
    }
    
    @objc func backButtonPressed() {
        savePixelProgress()
        retryButton.removeFromSuperview()
        backButton.removeFromSuperview()
        finishButton.removeFromSuperview()
        if canExit {
            if let gameViewController = self.view?.window?.rootViewController as? GameViewController {
                gameViewController.transitionToEndGameScene()
            }
        } else if canExit == false {
            if let gameViewController = self.view?.window?.rootViewController as? GameViewController {
                gameViewController.transitionToGameScene()
            }
        }
    }
    
    @objc func finishButtonPressed() {
        let accuracy = calculateAccuracy()
        if accuracy >= accuracyThreshold {
            displayResult(win: true)
            canExit = true
            replaceArtWithPainting()
        } else {
            displayResult(win: false)
            resetMiniGame()
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
        playerPixels = Array(repeating: Array(repeating: .clear, count: numColumns), count: numRows)
        
        if let savedPixels = UserDefaults.standard.array(forKey: "touchedPixels") as? [[Int]] {
            for pixel in savedPixels {
                if pixel.count == 3 {
                    let row = pixel[0]
                    let column = pixel[1]
                    let colorValue = pixel[2]
                    let pixelColor: SKColor = (colorValue == 1) ? .green : .red
                    
                    if row < numRows && column < numColumns {
                        playerPixels[row][column] = pixelColor
                        
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
        playerPixels = Array(repeating: Array(repeating: .clear, count: numColumns), count: numRows)
        
        for node in self.children {
            if let pixelNode = node as? PixelNode {
                pixelNode.fillColor = .clear
            }
        }
        
        isTracingSuccessful = false
    }
    
    func setupImage() {
        artNode = SKSpriteNode(imageNamed: "MonalisaTracing")
        artNode.alpha = 0.4
        artNode.setScale(1.67)
        artNode.position = CGPoint(x: size.width / 2, y: size.height / 2 - 1)
        artNode.zPosition = -1
        addChild(artNode)
    }
    
    func replaceArtWithPainting() {
        artNode.texture = SKTexture(imageNamed: "MonalisaOnly")
        artNode.alpha = 1.0
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
            referencePixels[row][column] = .black
        }
    }
    
    func setupTrace() {
        let startX = frame.midX - CGFloat(numColumns) / 2 * (pixelSize + pixelSpacing)
        let startY = frame.midY - CGFloat(numRows) / 2 * (pixelSize + pixelSpacing)
        
        for row in 0..<numRows {
            var rowArray: [SKColor?] = []
            for column in 0..<numColumns {
                let trace = PixelNode(rectOf: CGSize(width: pixelSize, height: pixelSize))
                
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
        
        accuracyLabel.text = "Accuracy: \(Int(roundedAccuracy))%"
        
        return roundedAccuracy
    }
    
    func setupFinishButton() {
        finishButton.accessibilityIdentifier = "finishButton"
        finishButton.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
        self.view?.addSubview(finishButton)
        finishButton.frame = CGRect(x: 600, y: 270, width: 150, height: 100)
        
        if let buttonImage = UIImage(named: "FinishButton-Default.svg") {
            finishButton.setImage(buttonImage, for: .normal)
        }
        
        finishButton.layer.zPosition = 3
    }
    
    func setupRetryButton() {
        retryButton.accessibilityIdentifier = "retryButton"
        retryButton.frame = CGRect(x: 200, y: 25, width: 150, height: 100)
        
        if let buttonImage = UIImage(named: "RetryButton") {
            retryButton.setImage(buttonImage, for: .normal)
        }
        
        retryButton.imageView?.contentMode = .scaleAspectFit
        retryButton.layer.zPosition = 3
        retryButton.addTarget(self, action: #selector(retryButtonPressed), for: .touchUpInside)
        
        self.view?.addSubview(retryButton)
    }
    
    func setupBackButton() {        backButton.accessibilityIdentifier = "backButton"
        backButton.frame = CGRect(x: 50, y: 25, width: 150, height: 100)
        
        if let buttonImage = UIImage(named: "BackButton") {
            backButton.setImage(buttonImage, for: .normal)
        }
        
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.layer.zPosition = 3
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        self.view?.addSubview(backButton)
    }
    
    func displayResult(win: Bool) {
        if let resultNode = resultNode {
            resultNode.removeFromParent()
        }
        let resultTexture = SKTexture(imageNamed: win ? "winTexture" : "loseTexture")
        resultNode = SKSpriteNode(texture: resultTexture)
        resultNode?.position = CGPoint(x: size.width / 2, y: size.height / 2)
        resultNode?.setScale(0.8)
        resultNode?.zPosition = 5
        addChild(resultNode!)
    }
}
