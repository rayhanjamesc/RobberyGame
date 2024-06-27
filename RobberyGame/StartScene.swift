//
//  StartScene.swift
//  RobberyGame
//
//  Created by Medeline Agustine on 24/06/24.
//

import Foundation
import SpriteKit
import GameKit

class StartScene: SKScene {
    override func didMove(to view: SKView) {
        let startButton = UIButton(type: .custom)
        startButton.setTitle("Start Game", for: .normal)
        startButton.setTitleColor(.blue, for: .normal)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        self.view?.addSubview(startButton)
        startButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    
    @objc func startButtonPressed() {
        if let gameViewController = self.view?.window?.rootViewController as? GameViewController {
            
            //gameViewController.gameCenterHelper.presentMatchmaker()
            gameViewController.findMatch()
            gameViewController.transitionToGameScene()
        }
    }
}
