//
//  StartScene.swift
//  RobberyGame
//
//  Created by Medeline Agustine on 24/06/24.
//

import Foundation
import SpriteKit

class StartScene: SKScene {
    var startButton: UIButton?
    var logoImageView: UIImageView?
    
    override func didMove(to view: SKView) {
        // Set up background image
        let background = SKSpriteNode(imageNamed: "LandingPage.png")
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.zPosition = -1
        background.size = self.size
        self.addChild(background)
        
        // Initialize the start button
        let startButton = UIButton(type: .custom)
        if let buttonImage = UIImage(named: "playButtonDefault.png") {
            startButton.setImage(buttonImage, for: .normal)
        }
        
        // Set the image for when the button is pressed
        if let buttonPressedImage = UIImage(named: "playButtonPressed.png") {
            startButton.setImage(buttonPressedImage, for: .highlighted)
        }
        
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        self.view?.addSubview(startButton)
        
        // Original size
        let originalWidth: CGFloat = 100
        let originalHeight: CGFloat = 50
        
        // Scale factor
        let scaleFactor: CGFloat = 2.0
        
        // Calculate new size
        let newWidth = originalWidth * scaleFactor
        let newHeight = originalHeight * scaleFactor
        
        startButton.frame = CGRect(x: (self.view?.frame.midX ?? 0) - newWidth / 2, y: 235, width: newWidth, height: newHeight)
        
        // Store button in property to access later
        self.startButton = startButton
        
        // Logo image above play button
        let logoImageView = UIImageView(image: UIImage(named: "Logo.png"))
        let logoWidth: CGFloat = 300
        let logoHeight: CGFloat = 300
        logoImageView.frame = CGRect(x: (self.view?.frame.midX ?? 0) - (logoWidth / 2), y: startButton.frame.minY - logoHeight - 20, width: logoWidth, height: logoHeight)
        self.view?.addSubview(logoImageView)
        
        // Store logo image view in property to access later
        self.logoImageView = logoImageView
    }
    
    @objc func startButtonPressed() {
        // Remove button and logo from superview when pressed
        startButton?.removeFromSuperview()
        logoImageView?.removeFromSuperview()
        
        if let gameViewController = self.view?.window?.rootViewController as? GameViewController {
            gameViewController.transitionToGameScene()
        }
    }
}
