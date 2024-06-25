//
//  GameViewController.swift
//  RobberyGame
//
//  Created by James Cellars on 11/06/24.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = GameScene(size: view.bounds.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
        }
    }
    
    //Method to transition to Mini Game Scene
    func transitionToMiniGameScene() {
        if let view = self.view as! SKView? {
            let miniGameScene = MiniGameScene(size: view.bounds.size)
            
            miniGameScene.scaleMode = .aspectFill
            view.presentScene(miniGameScene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
        }
    }
    
    //Method to transition to Game Scene
    func transitionToGameScene() {
        if let view = self.view as! SKView? {
            let scene = GameScene(size: view.bounds.size)
            
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
        }
    }
    
    //Method to transition to End Game Scene
    func transitionToEndGameScene() {
        if let view = self.view as! SKView? {
            let scene = EndGameScene(size: view.bounds.size)
            
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
