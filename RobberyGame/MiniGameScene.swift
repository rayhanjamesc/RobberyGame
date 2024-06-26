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
    
    //Constants for pixel grid size and spacing
    let pixelSize: CGFloat = 16 // Size of each pixel
    let pixelSpacing: CGFloat = 1  // Spacing between pixels
    let numRows = 28
    let numColumns = 20
    
    var referencePixels: [[SKColor]] = []
    var playerPixels: [[SKColor?]] = []
    
    let accuracyThreshold: Double = 100.0
    var isTracingSuccessful: Bool = false
    
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: 1334, height: 750)
        self.scaleMode = .aspectFit
        
        setupImage()
        setupTrace()
        setupFinishButton()
        setupReference()
//        displayReferencePixels()
        
        //Add back to map button
        let mapButton = UIButton(type: .custom)
        mapButton.setTitle("Back to map", for: .normal)
        mapButton.setTitleColor(.blue, for: .normal)
        mapButton.addTarget(self, action: #selector(mapButtonPressed), for: .touchUpInside)
        self.view?.addSubview(mapButton)
        mapButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        //Add retry button
        let retryButton = SKLabelNode(fontNamed: "Helvetica")
        retryButton.text = "Retry"
        retryButton.fontSize = 24
        retryButton.fontColor = SKColor.green
        retryButton.position = CGPoint(x: 0, y: 50)
        retryButton.name = "Retry"
        addChild(retryButton)
        
        // Set the background color
        self.backgroundColor = UIColor(Color.theme.background)

    }
    
    
    @objc func mapButtonPressed() {
        if let gameViewController = self.view?.window?.rootViewController as? GameViewController {
            if isTracingSuccessful {
                gameViewController.transitionToEndGameScene()
            } else {
                gameViewController.transitionToGameScene()
            }
        }
    }
    
    func resetMiniGame() {
        //Clear player pixels
        playerPixels = Array(repeating: Array(repeating: .clear, count: numColumns), count: numRows)
        
        //Clear pixel nodes
        for node in self.children {
            if let pixelNode = node as? PixelNode {
                pixelNode.fillColor = .clear
            }
        }
        
        isTracingSuccessful = false
    }
    
    func setupImage() {
        let art = SKSpriteNode(imageNamed: "Monalisa_Pixel")
//        art.setScale(20)
        art.position = CGPoint(x: size.width / 3, y: size.height / 2)
        art.zPosition = -1
        addChild(art)
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
//    
//    func displayReferencePixels() {
//        for row in 0..<numRows {
//            for column in 0..<numColumns {
//                if referencePixels[row][column] != .clear {
//                    let pixelNode = SKShapeNode(rectOf: CGSize(width: pixelSize, height: pixelSize))
//                    pixelNode.position = CGPoint(
//                        x: CGFloat(column) * (pixelSize + pixelSpacing),
//                        y: CGFloat(row) * (pixelSize + pixelSpacing)
//                    )
//                    pixelNode.fillColor = referencePixels[row][column]
//                    pixelNode.strokeColor = .clear
//                    addChild(pixelNode)
//                }
//            }
//        }
//    }

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
                
                trace.position = CGPoint(x: 8 + startX/2.5 + CGFloat(column) * (pixelSize + pixelSpacing),
                                         y: 8 + startY + CGFloat(row) * (pixelSize + pixelSpacing))
//                trace.position = CGPoint(x: 2 + size.width / 2, y: 2 + size.height / 2)
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
            
            print(pixelNode.row, pixelNode.column)
        } else if let finishButton = self.atPoint(touchLocation) as? SKLabelNode, finishButton.name == "finishButton" {
            let accuracy = calculateAccuracy()
            print("Accuracy: \(accuracy)%")
            
            if accuracy < accuracyThreshold {
                //Shows retry button if accuracy is below threshold
                if let retryButton = self.view?.subviews.first(where: { $0 is UIButton && ($0 as! UIButton).title(for: .normal) == "Retry"}) {
                    retryButton.isHidden = false
                }
            }
        } else if let retryButton = self.atPoint(touchLocation) as? SKLabelNode, retryButton.name == "Retry" {
            //Handle retry button click
            resetMiniGame()
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
                if playerPixels[row][column] == .red {
                    inputCount += 1
                    if markedCoordinatesSet.contains(coordinateString) {
                        correctCount += 1
                    } else {
                        wrongCount += 1
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
        let roundedAccuracy = Double(round(accuracy * 100) / 100)
        
        return roundedAccuracy
    }

//    
//    func calculateAccuracy() -> Double {
//        let markedCoordinates = [
//            (25, 9), (25, 10), (25, 11),
//            (24, 8), (24, 12), (24, 13),
//            (23, 7), (23, 14),
//            (22, 6), (22, 14),
//            (21, 6), (21, 15),
//            (20, 6), (20, 15),
//            (19, 6), (19, 15),
//            (18, 6), (18, 15),
//            (17, 7), (17, 15),
//            (16, 7), (16, 15),
//            (15, 6), (15, 16),
//            (14, 5), (14, 17),
//            (13, 4), (13, 18),
//            (12, 3), (12, 18),
//            (11, 3), (11, 18),
//            (10, 2), (10, 18),
//            (9, 1), (9, 18),
//            (8, 1), (8, 19),
//            (7, 1),
//            (6, 0)
//        ]
//        
//        var correctCount = 0
//        var wrongCount = 0
//        var inputCount = 0
//        
//        for (row, column) in markedCoordinates {
//            inputCount += 1
//            if playerPixels[row][column] == .red {
//                correctCount += 1
//            } else {
//                wrongCount += 1
//            }
//        }
//        
//        let totalMarkedCoordinates = markedCoordinates.count
//        let errorScore = (Double(wrongCount/inputCount)) * 100
//        let correctScore = (Double(correctCount) / Double(totalMarkedCoordinates)) * 100
//        let finalCount = correctScore - errorScore
//        let accuracy = totalMarkedCoordinates > 0 ? finalCount : 0
//
//        
//        return accuracy
//    }

//    func calculateAccuracy() -> Double {
//        var correctPixels = 0
//        var totalPixels = 0
//        
//        for row in 0..<numRows {
//            for column in 0..<numColumns {
//                totalPixels += 1
//                let playerColor = playerPixels[row][column]
//                if playerColor == referencePixels[row][column] {
//                    correctPixels += 1
//                }
//            }
//            
//        }
//        
//        print("total pixels: \(totalPixels)")
//        print("correct pixels: \(correctPixels)")
//        
//        var accuracy = totalPixels > 0 ? (Double(correctPixels) / Double(totalPixels)) * 100 : 0
//        if accuracy > accuracyThreshold {
//            isTracingSuccessful = true
//        }
//        
//        return totalPixels > 0 ? (Double(correctPixels) / Double(totalPixels)) * 100 : 0
//    }
    
    func setupFinishButton() {
        //                let finishButton = SKLabelNode(text: "Finish")
        //        finishButton.fontSize = 30
        //        finishButton.fontColor = .green
        //        finishButton.position = CGPoint(x: 300, y: size.height / 2)
        //        finishButton.name = "finishButton"
        //        addChild(finishButton)
        //
        
        let finishButton = UIButton(type: .custom)
        if let finishButtonImage = UIImage(named: "finish.svg") {
            finishButton.setImage(finishButtonImage, for: .normal)
            
            //        finishButton.layer.position(x: 30, y:40)
            
            //        finishButton.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
            
            
            //        finishButton.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
            
            // Set the position and size of the button
            finishButton.frame = CGRect(x: (self.view?.bounds.width ?? 0) / 2 - 50,
                                        y: (self.view?.bounds.height ?? 0) / 2 - 50,
                                        width: 200,
                                        height: 100)
            
            // Add the button to the view
            self.view?.addSubview(finishButton)
        }
    }
}
