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
    var match: GKMatch!
    var localPlayer: GKPlayer?
    var remotePlayer: GKPlayer?
    
    var gameViewController: GameViewController!

    var gameScene: GameScene!
    
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
            view.showsPhysics = false
        }
        
        authenticateLocalPlayer()
    }
    
    func authenticateLocalPlayer() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = { viewController, error in
            if let vc = viewController {
                self.present(vc, animated: true, completion: nil)
            } else if localPlayer.isAuthenticated {
                self.localPlayer = localPlayer
                print("Player is authenticated")
            } else {
                print("Player is not authenticated: \(error?.localizedDescription ?? "Unknown error")")
            }
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

extension GameViewController: GKMatchmakerViewControllerDelegate {
    
    func findMatch() {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        request.inviteMessage = "Let's steal painting together!"
        
        let matchmakerVC = GKMatchmakerViewController(matchRequest: request)!
        matchmakerVC.matchmakerDelegate = self
        self.present(matchmakerVC, animated: true, completion: nil)
        print("present matchmaker")
    }
    
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        viewController.dismiss(animated: true, completion: nil)
        print("Error finding match: \(error.localizedDescription)")
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        viewController.dismiss(animated: true, completion: nil)
        self.match = match
        self.match?.delegate = self
        assignPlayers(match: match)
    }
    
    func assignPlayers(match: GKMatch) {
        guard let localPlayer = localPlayer else { return }
        if let remotePlayer = match.players.first(where: { $0.gamePlayerID != localPlayer.gamePlayerID }) {
            self.remotePlayer = remotePlayer
            // Assign players to classes
            assignPlayerClasses()
        }
        print("players assigned")
    }
    
    func assignPlayerClasses() {
        guard let scene = self.view as? SKView, let gameScene = scene.scene as? GameScene else { return }
        
        gameScene.match = self.match

        if localPlayer?.gamePlayerID ?? "" < remotePlayer?.gamePlayerID ?? "" {
            // Local player is PlayerA, remote player is PlayerB
            gameScene.playerA.name = localPlayer?.alias
            gameScene.playerB.name = remotePlayer?.alias
            gameScene.playerA.isLocalPlayer = true
        } else {
            // Local player is PlayerB, remote player is PlayerA
            gameScene.playerA.name = remotePlayer?.alias
            gameScene.playerB.name = localPlayer?.alias
            gameScene.playerB.isLocalPlayer = true
        }
        
        if gameScene.playerA.isLocalPlayer {
            gameScene.player = gameScene.playerA
            gameScene.remotePlayer = gameScene.playerB
        } else {
            gameScene.player = gameScene.playerB
            gameScene.remotePlayer = gameScene.playerA
        }
        
        gameScene.cameraNode.addChild(gameScene.player)
        gameScene.addChild(gameScene.remotePlayer)
        print("player classes assigned")
    }
    
}

extension GameViewController: GKMatchDelegate {
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        guard let scene = self.view as? SKView, let gameScene = scene.scene as? GameScene else { return }

        // Decode the received position data
        do {
            let position = try JSONDecoder().decode(CGPoint.self, from: data)
                    
            // Update remote player's position on the main thread
            DispatchQueue.main.async {
                gameScene.remotePlayer.position = position
//                gameScene.addChild(gameScene.remotePlayer)
                print("Received position: \(position)")
            }
        } catch {
            print("Error decoding position data: \(error.localizedDescription)")
        }
    }
    
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        if state == .disconnected {
            print("Player disconnected: \(player.alias)")
        }
    }
}




