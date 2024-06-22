//
//  GameViewController.swift
//  RobberyGame
//
//  Created by James Cellars on 11/06/24.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController, GKGameCenterControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateLocalPlayer()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
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
    
    func authenticateLocalPlayer() {
            let localPlayer = GKLocalPlayer.local
            localPlayer.authenticateHandler = { (viewController, error) in
                if let vc = viewController {
                    self.present(vc, animated: true, completion: nil)
                } else if localPlayer.isAuthenticated {
                    // Player is authenticated
                    print("Player authenticated")
                } else {
                    // Authentication failed
                    print("Authentication failed")
                }
            }
        }

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
