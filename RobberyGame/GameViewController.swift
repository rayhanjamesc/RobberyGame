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

class GameViewController: UIViewController {
    
    private var gameCenterHelper: GameCenterHelper!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = StartScene(size: view.bounds.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = true
        }
        
        gameCenterHelper = GameCenterHelper()
        gameCenterHelper.delegate = self
        gameCenterHelper.authenticatePlayer()
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
        gameCenterHelper.presentMatchmaker()
        if let view = self.view as! SKView? {
            let scene = GameScene(size: view.bounds.size)
            
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = true
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
    
    //Method to transition to Start Scene
    func transitionToStartScene() {
        if let view = self.view as! SKView? {
            let scene = StartScene(size: view.bounds.size)
            
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

extension GameViewController: GameCenterHelperDelegate {
    func didChangeAuthStatus(isAuthenticated: Bool) {
//        buttonMultiplayer.isEnabled = isAuthenticated
    }
    
    func presentGameCenterAuth(viewController: UIViewController?) {
        guard let vc = viewController else {return}
        self.present(vc, animated: true)
    }
    
    func presentMatchmaking(viewController: UIViewController?) {
        guard let vc = viewController else {return}
        self.present(vc, animated: true)
    }
    
    func presentGame(match: GKMatch) {
        //performSegue(withIdentifier: "showGame", sender: match)
    }
}

extension GameViewController: GKMatchDelegate {
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
//        guard let model = G.decode(data: data) else { return }
//        gameModel = model
    }
}
