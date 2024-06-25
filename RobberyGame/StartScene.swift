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
    
    override func didMove(to view: SKView) {
        let startButton = UIButton(type: .custom)
        startButton.setTitle("Start Game", for: .normal)
        startButton.setTitleColor(.blue, for: .normal)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        self.view?.addSubview(startButton)
        startButton.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        
        //Store button in property to access later
        self.startButton = startButton
    }
    
    
    @objc func startButtonPressed() {
        //Hides button when pressed
        startButton?.isHidden = true
        
        if let gameViewController = self.view?.window?.rootViewController as? GameViewController {
            gameViewController.transitionToGameScene()
        }
    }
}
