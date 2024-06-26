//
//  GameScene.swift
//  RobberyGame
//
//  Created by James Cellars on 11/06/24.
//

import SpriteKit
import GameplayKit
import GameKit
import Foundation

//Variables for Contact Test Bit Mask (Colliding)
let playerCol: UInt32 = 0x1 << 0
let topCol: UInt32 = 0x1 << 1
let rightCol: UInt32 = 0x1 << 2
let bottomCol: UInt32 = 0x1 << 3
let leftCol: UInt32 = 0x1 << 4
let diagonalTopLeftCol: UInt32 = 0x1 << 5
let diagonalTopRightCol: UInt32 = 0x1 << 6
let diagonalBottomLeftCol: UInt32 = 0x1 << 7
let diagonalBottomRightCol: UInt32 = 0x1 << 8
let obstacle: UInt32 = 0x1 << 9
let traceCol: UInt32 = 0x1 << 10

class GameScene: SKScene, SneakyJoystickDelegate, SKPhysicsContactDelegate {
    
    var match: GKMatch?
    var player1: Player!
    var player2: Player!
    
    //Creates and displays game over screen
    var gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    //Retry button
    var retryButton = SKLabelNode(fontNamed: "Chalkduster")
    
    //Trace button
    let traceButton = UIButton(type: .custom)
    
    //Start multiplayer
    func playerSetUp(with match: GKMatch) {
        self.match = match
        print("match")
            
        // Set up player 1 and player 2
        let player1Texture = SKTexture(imageNamed: "playerOne.png")
        player1 = Player(playerName: "Player 1", texture: player1Texture)
        player1.position = CGPoint(x: size.width * 0.2, y: size.height / 2)
        addChild(player1)
        print("Player One initiated")
        
        let player2Texture = SKTexture(imageNamed: "playerTwo.png")
        player2 = Player(playerName: "Player 2", texture: player2Texture)
        player2.position = CGPoint(x: size.width * 0.8, y: size.height / 2)
        addChild(player2)
        print("Player two initiated")
    }
    
    //    private func getLocalPlayer() {
    //        if player1.playerName == GKLocalPlayer.local.displayName {
    //            player = player1
    //        } else {
    //            player = player2
    //        }
    //    }
    
    //Create joystick on scene
    let joystick = Joystick()
    
    //Create player instance
    let player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
    
    //Create camera node
    let cameraNode = SKCameraNode()
    
    //Reference to GameViewController
    weak var gameViewController: GameViewController?
    
    //Win mechanic conditional
    let cctv1 = CCTVTop()
    let cctv2 = CCTVDown()
    let cctv3 = CCTVTop()
    let cctv4 = CCTVDown()
    let range1 = CCTVRange()
    let range2 = CCTVRange()
    let range3 = CCTVRange()
    let range4 = CCTVRange()
    let bear = Bear()
    let track = GuardTrack()
    
    //Game walls
    let room1_1 = SKSpriteNode(imageNamed: "room1_1.png")
    let room1_2 = SKSpriteNode(imageNamed: "room1_2.png")
    let room1_3 = SKSpriteNode(imageNamed: "room1_3.png")
    let hallway1_1 = SKSpriteNode(imageNamed: "hallway1_1.png")
    let hallway1_2 = SKSpriteNode(imageNamed: "hallway1_2.png")
    let room1_4 = SKSpriteNode(imageNamed: "room1_4.png")
    let room1_5 = SKSpriteNode(imageNamed: "room1_5.png")
    
    let partition2_1 = SKSpriteNode(imageNamed: "partitionwall2_1")
    let partition2_2 = SKSpriteNode(imageNamed: "partitionwall2_2")
    let partition2_3 = SKSpriteNode(imageNamed: "partitionwall2_3")
    let partition2_4 = SKSpriteNode(imageNamed: "partitionwall2_4")
    let partitionMain = SKSpriteNode(imageNamed: "partitionMain.png")
    let partitionLeft = SKSpriteNode(imageNamed: "partitionLeft.png")
    let partitionRight = SKSpriteNode(imageNamed: "partitionRight.png")
    
    //Lines for partitions
    let lineLeft21 = SKShapeNode()
    let lineTop21 = SKShapeNode()
    let lineRight21 = SKShapeNode()
    let lineLeft22 = SKShapeNode()
    let lineBottom22 = SKShapeNode()
    let lineRight22 = SKShapeNode()
    let lineLeft23 = SKShapeNode()
    let lineTop23 = SKShapeNode()
    let lineRight23 = SKShapeNode()
    let lineLeft24 = SKShapeNode()
    let lineBottom24 = SKShapeNode()
    let lineRight24 = SKShapeNode()
    let traceLine = SKShapeNode()
    
    let room2_1 = SKSpriteNode(imageNamed: "room2_1.png")
    let room2_2 = SKSpriteNode(imageNamed: "room2_2.png")
    let room2_3 = SKSpriteNode(imageNamed: "room2_3.png")
    let room2_4 = SKSpriteNode(imageNamed: "room2_4.png")
    let room2_5 = SKSpriteNode(imageNamed: "room2_5.png")
    let room2_6 = SKSpriteNode(imageNamed: "room2_6.png")
    let room2_7 = SKSpriteNode(imageNamed: "room2_7.png")
    let room2_8 = SKSpriteNode(imageNamed: "room2_8.png")
    let room2_9 = SKSpriteNode(imageNamed: "room2_9.png")
    let hallway2_1 = SKSpriteNode(imageNamed: "hallway2_1.png")
    let hallway2_2 = SKSpriteNode(imageNamed: "hallway2_2.png")
    let room2_10 = SKSpriteNode(imageNamed: "room2_10.png")
    let room2_11 = SKSpriteNode(imageNamed: "room2_11.png")
    let room2_12 = SKSpriteNode(imageNamed: "room2_12.png")
    let room2_13 = SKSpriteNode(imageNamed: "room2_13.png")
    let room2_14 = SKSpriteNode(imageNamed: "room2_14.png")
    let room2_15 = SKSpriteNode(imageNamed: "room2_15.png")
    let room2_16 = SKSpriteNode(imageNamed: "room2_16.png")
    let room2_17 = SKSpriteNode(imageNamed: "room2_17.png")
    let room2_18 = SKSpriteNode(imageNamed: "room2_18.png")
    
    let room3_1 = SKSpriteNode(imageNamed: "room3_1.png")
    let room3_2 = SKSpriteNode(imageNamed: "room3_2.png")
    let room3_3 = SKSpriteNode(imageNamed: "room3_3.png")
    let room3_4 = SKSpriteNode(imageNamed: "room3_4.png")
    let room3_5 = SKSpriteNode(imageNamed: "room3_5.png")
    let room3_6 = SKSpriteNode(imageNamed: "room3_6.png")
    let room3_7 = SKSpriteNode(imageNamed: "room3_7.png")
    let room3_8 = SKSpriteNode(imageNamed: "room3_8.png")
    let room3_9 = SKSpriteNode(imageNamed: "room3_9.png")
    
    //Interactable items
    let painting = SKSpriteNode(imageNamed: "MonaLisa")
    
    //Checking if player is currently colliding with respective borders
    var isPlayerTouchingBorder = false
    var isTouchingTop = false
    var isTouchingRight = false
    var isTouchingBottom = false
    var isTouchingLeft = false
    var isTouchingDiagonalTopLeft = false
    var isTouchingDiagonalTopRight = false
    var isTouchingDiagonalBottomLeft = false
    var isTouchingDiagonalBottomRight = false
    var isTriggeringTrace = false
    
    //Timer properties
    var timerLabel: SKLabelNode!
    var countdown: Int = 3
    var isTimerRunning = false
    
    override func didMove(to view: SKView) {
        view.showsPhysics = true
        view.showsNodeCount = true
        view.showsFPS = true
        
        //Set screen size for horizontal layout
        self.size = CGSize(width: 1334, height: 750)
        self.scaleMode = .aspectFit
        
        physicsWorld.contactDelegate = self
        
        // Physics body for elements
        range1.physicsBody?.categoryBitMask = obstacle
        range1.physicsBody?.collisionBitMask = playerCol
        range2.physicsBody?.categoryBitMask = obstacle
        range2.physicsBody?.collisionBitMask = playerCol
        range3.physicsBody?.categoryBitMask = obstacle
        range3.physicsBody?.collisionBitMask = playerCol
        range4.physicsBody?.categoryBitMask = obstacle
        range4.physicsBody?.collisionBitMask = playerCol
        bear.physicsBody?.categoryBitMask = obstacle
        bear.physicsBody?.collisionBitMask = playerCol
        
        //Physics body for left walls
        
            room1_1.physicsBody = SKPhysicsBody(texture: room1_1.texture!, size: room1_1.size)
            room1_1.physicsBody?.categoryBitMask = leftCol
            room1_1.physicsBody?.collisionBitMask = playerCol
            
            room1_2.physicsBody = SKPhysicsBody(texture: room1_2.texture!, size: room1_2.size)
            room1_2.physicsBody?.categoryBitMask = topCol
            room1_2.physicsBody?.collisionBitMask = playerCol
            
            room1_3.physicsBody = SKPhysicsBody(texture: room1_3.texture!, size: room1_3.size)
            room1_3.physicsBody?.categoryBitMask = rightCol
            room1_3.physicsBody?.collisionBitMask = playerCol
        
            hallway1_1.physicsBody = SKPhysicsBody(texture: hallway1_1.texture!, size: hallway1_1.size)
            hallway1_1.physicsBody?.categoryBitMask = topCol
            hallway1_1.physicsBody?.collisionBitMask = playerCol
        
            room1_4.physicsBody = SKPhysicsBody(texture: room1_4.texture!, size: room1_4.size)
            room1_4.physicsBody?.categoryBitMask = rightCol
            room1_4.physicsBody?.collisionBitMask = playerCol
        
            room1_5.physicsBody = SKPhysicsBody(texture: room1_5.texture!, size: room1_5.size)
            room1_5.physicsBody?.categoryBitMask = bottomCol
            room1_5.physicsBody?.collisionBitMask = playerCol
            
            hallway1_2.physicsBody = SKPhysicsBody(texture: hallway1_2.texture!, size: hallway1_2.size)
            hallway1_2.physicsBody?.categoryBitMask = bottomCol
            hallway1_2.physicsBody?.collisionBitMask = playerCol
        
            lineLeft21.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 750, y: -500), to: CGPoint(x: 750, y: 65))
            lineLeft21.physicsBody?.categoryBitMask = rightCol
            lineLeft21.physicsBody?.collisionBitMask = playerCol
            
            lineTop21.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 750, y: 65), to: CGPoint(x: 782, y: 65))
            lineTop21.physicsBody?.categoryBitMask = bottomCol
            lineTop21.physicsBody?.collisionBitMask = playerCol

            lineRight21.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 782, y: 65), to: CGPoint(x: 782, y: -500))
            lineRight21.physicsBody?.categoryBitMask = leftCol
            lineRight21.physicsBody?.collisionBitMask = playerCol
            
            lineLeft22.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 990, y: 500), to: CGPoint(x: 990, y: -150))
            lineLeft22.physicsBody?.categoryBitMask = rightCol
            lineLeft22.physicsBody?.collisionBitMask = playerCol
            
            lineBottom22.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 990, y: -150), to: CGPoint(x: 1025, y: -150))
            lineBottom22.physicsBody?.categoryBitMask = topCol
            lineBottom22.physicsBody?.collisionBitMask = playerCol
            
            lineRight22.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1025, y: -150), to: CGPoint(x: 1025, y: 500))
            lineRight22.physicsBody?.categoryBitMask = leftCol
            lineRight22.physicsBody?.collisionBitMask = playerCol
        
            lineLeft23.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1560, y: -400), to: CGPoint(x: 1560, y: 112))
            lineLeft23.physicsBody?.categoryBitMask = rightCol
            lineLeft23.physicsBody?.collisionBitMask = playerCol
            
            lineTop23.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1560, y: 112), to: CGPoint(x: 1600, y: 112))
            lineTop23.physicsBody?.categoryBitMask = bottomCol
            lineTop23.physicsBody?.collisionBitMask = playerCol
            
            lineRight23.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1600, y: 112), to: CGPoint(x: 1600, y: -400))
            lineRight23.physicsBody?.categoryBitMask = leftCol
            lineRight23.physicsBody?.collisionBitMask = playerCol
        
            lineLeft24.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1825, y: 500), to: CGPoint(x: 1825, y: -120))
            lineLeft24.physicsBody?.categoryBitMask = rightCol
            lineLeft24.physicsBody?.collisionBitMask = playerCol
            
            lineBottom24.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1825, y: -120), to: CGPoint(x: 1855, y: -120))
            lineBottom24.physicsBody?.categoryBitMask = topCol
            lineBottom24.physicsBody?.collisionBitMask = playerCol
            
            lineRight24.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1855, y: -120), to: CGPoint(x: 1855, y: 500))
            lineRight24.physicsBody?.categoryBitMask = leftCol
            lineRight24.physicsBody?.collisionBitMask = playerCol

            room2_1.physicsBody = SKPhysicsBody(texture: room2_1.texture!, size: room2_1.size)
            room2_1.physicsBody?.categoryBitMask = leftCol
            room2_1.physicsBody?.collisionBitMask = playerCol
            
            room2_2.physicsBody = SKPhysicsBody(texture: room2_2.texture!, size: room2_2.size)
            room2_2.physicsBody?.categoryBitMask = topCol
            room2_2.physicsBody?.collisionBitMask = playerCol
        
            cctv1.zPosition = 3
            cctv1.position = CGPoint(x: -100, y: 20)
            room2_2.addChild(cctv1)
            cctv1.addChild(range1)
            range1.position = CGPoint(x: 20, y: -5)

            range1.startMovementAnimation(turnDirection: 1)
        
            room2_3.physicsBody = SKPhysicsBody(texture: room2_3.texture!, size: room2_3.size)
            room2_3.physicsBody?.categoryBitMask = leftCol
            room2_3.physicsBody?.collisionBitMask = playerCol
        
            room2_4.physicsBody = SKPhysicsBody(texture: room2_4.texture!, size: room2_4.size)
            room2_4.physicsBody?.categoryBitMask = diagonalTopLeftCol
            room2_4.physicsBody?.collisionBitMask = playerCol
        
            room2_5.physicsBody = SKPhysicsBody(texture: room2_5.texture!, size: room2_5.size)
            room2_5.physicsBody?.categoryBitMask = topCol
            room2_5.physicsBody?.collisionBitMask = playerCol
        
            room2_6.physicsBody = SKPhysicsBody(texture: room2_6.texture!, size: room2_6.size)
            room2_6.physicsBody?.categoryBitMask = diagonalTopRightCol
            room2_6.physicsBody?.collisionBitMask = playerCol
            
            room2_7.physicsBody = SKPhysicsBody(texture: room2_7.texture!, size: room2_7.size)
            room2_7.physicsBody?.categoryBitMask = rightCol
            room2_7.physicsBody?.collisionBitMask = playerCol
            addChild(track)
            track.position = CGPoint(x: 1500, y: -200)
            
            room2_8.physicsBody = SKPhysicsBody(texture: room2_8.texture!, size: room2_8.size)
            room2_8.physicsBody?.categoryBitMask = topCol
            room2_8.physicsBody?.collisionBitMask = playerCol
            
            cctv3.xScale = 1.0
            cctv3.zPosition = 3
            range3.zPosition = 3
            room2_8.addChild(cctv3)
            cctv3.addChild(range3)
            cctv3.position = CGPoint(x: -85, y: 30)
            range3.position = CGPoint(x: 20, y: 10)
            range3.startMovementAnimation(turnDirection: 3)
        
            room2_9.physicsBody = SKPhysicsBody(texture: room2_9.texture!, size: room2_9.size)
            room2_9.physicsBody?.categoryBitMask = rightCol
            room2_9.physicsBody?.collisionBitMask = playerCol
        
            hallway2_1.physicsBody = SKPhysicsBody(texture: hallway2_1.texture!, size: hallway2_1.size)
            hallway2_1.physicsBody?.categoryBitMask = topCol
            hallway2_1.physicsBody?.collisionBitMask = playerCol
            
            hallway2_2.physicsBody = SKPhysicsBody(texture: hallway2_2.texture!, size: hallway2_2.size)
            hallway2_2.physicsBody?.categoryBitMask = bottomCol
            hallway2_2.physicsBody?.collisionBitMask = playerCol
        
            room2_10.physicsBody = SKPhysicsBody(texture: room2_10.texture!, size: room2_10.size)
            room2_10.physicsBody?.categoryBitMask = rightCol
            room2_10.physicsBody?.collisionBitMask = playerCol
        
            room2_11.physicsBody = SKPhysicsBody(texture: room2_11.texture!, size: room2_11.size)
            room2_11.physicsBody?.categoryBitMask = bottomCol
            room2_11.physicsBody?.collisionBitMask = playerCol
        
            cctv4.zPosition = 3
            cctv4.xScale = 1.0
            cctv4.position = CGPoint(x: 100, y: 30)
            room2_11.addChild(cctv4)
            cctv4.addChild(range4)
            range4.zRotation = .pi
            range4.position = CGPoint(x: 20, y: 13)
            range4.startMovementAnimation(turnDirection: 4)
        
            room2_12.physicsBody = SKPhysicsBody(texture: room2_12.texture!, size: room2_12.size)
            room2_12.physicsBody?.categoryBitMask = rightCol
            room2_12.physicsBody?.collisionBitMask = playerCol
        
            room2_13.physicsBody = SKPhysicsBody(texture: room2_13.texture!, size: room2_13.size)
            room2_13.physicsBody?.categoryBitMask = diagonalBottomRightCol
            room2_13.physicsBody?.collisionBitMask = playerCol
        
            room2_14.physicsBody = SKPhysicsBody(texture: room2_14.texture!, size: room2_14.size)
            room2_14.physicsBody?.categoryBitMask = bottomCol
            room2_14.physicsBody?.collisionBitMask = playerCol
        
            room2_15.physicsBody = SKPhysicsBody(texture: room2_15.texture!, size: room2_15.size)
            room2_15.physicsBody?.categoryBitMask = diagonalBottomLeftCol
            room2_15.physicsBody?.collisionBitMask = playerCol
        
            room2_16.physicsBody = SKPhysicsBody(texture: room2_16.texture!, size: room2_16.size)
            room2_16.physicsBody?.categoryBitMask = leftCol
            room2_16.physicsBody?.collisionBitMask = playerCol
        
            room2_17.physicsBody = SKPhysicsBody(texture: room2_17.texture!, size: room2_17.size)
            room2_17.physicsBody?.categoryBitMask = bottomCol
            room2_17.physicsBody?.collisionBitMask = playerCol
        
            cctv2.zPosition = 3
            cctv2.position = CGPoint(x: 100, y: 30)
            room2_17.addChild(cctv2)
            cctv2.addChild(range2)
            range2.zRotation = .pi
            range2.position = CGPoint(x: 20, y: 13)
            range2.startMovementAnimation(turnDirection: 2)
        
            room2_18.physicsBody = SKPhysicsBody(texture: room2_18.texture!, size: room2_18.size)
            room2_18.physicsBody?.categoryBitMask = leftCol
            room2_18.physicsBody?.collisionBitMask = playerCol
        
            room3_1.physicsBody = SKPhysicsBody(texture: room3_1.texture!, size: room3_1.size)
            room3_1.physicsBody?.categoryBitMask = leftCol
            room3_1.physicsBody?.collisionBitMask = playerCol
            
            room3_2.physicsBody = SKPhysicsBody(texture: room3_2.texture!, size: room3_2.size)
            room3_2.physicsBody?.categoryBitMask = diagonalTopLeftCol
            room3_2.physicsBody?.collisionBitMask = playerCol
        
            room3_3.physicsBody = SKPhysicsBody(texture: room3_3.texture!, size: room3_3.size)
            room3_3.physicsBody?.categoryBitMask = diagonalTopLeftCol
            room3_3.physicsBody?.collisionBitMask = playerCol
        
            room3_4.physicsBody = SKPhysicsBody(texture: room3_4.texture!, size: room3_4.size)
            room3_4.physicsBody?.categoryBitMask = topCol
            room3_4.physicsBody?.collisionBitMask = playerCol
        
            room3_5.physicsBody = SKPhysicsBody(texture: room3_5.texture!, size: room3_5.size)
            room3_5.physicsBody?.categoryBitMask = diagonalTopRightCol
            room3_5.physicsBody?.collisionBitMask = playerCol
        
            room3_6.physicsBody = SKPhysicsBody(texture: room3_6.texture!, size: room3_6.size)
            room3_6.physicsBody?.categoryBitMask = diagonalTopRightCol
            room3_6.physicsBody?.collisionBitMask = playerCol
            
            room3_7.physicsBody = SKPhysicsBody(texture: room3_7.texture!, size: room3_7.size)
            room3_7.physicsBody?.categoryBitMask = rightCol
            room3_7.physicsBody?.collisionBitMask = playerCol
            
            room3_8.physicsBody = SKPhysicsBody(texture: room3_8.texture!, size: room3_8.size)
            room3_8.physicsBody?.categoryBitMask = bottomCol
            room3_8.physicsBody?.collisionBitMask = playerCol
        
            room3_9.physicsBody = SKPhysicsBody(texture: room3_9.texture!, size: room3_9.size)
            room3_9.physicsBody?.categoryBitMask = leftCol
            room3_9.physicsBody?.collisionBitMask = playerCol
        
            partitionMain.physicsBody = SKPhysicsBody(texture: partitionMain.texture!, size: partitionMain.size)
            partitionMain.physicsBody?.categoryBitMask = topCol
            partitionMain.physicsBody?.collisionBitMask = playerCol
        
            traceLine.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 2520, y: 300), to: CGPoint(x: 2720, y: 300))
            traceLine.physicsBody?.categoryBitMask = traceCol
            traceLine.physicsBody?.collisionBitMask = playerCol
        
        //Create physics body for player
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height))
        
        //Category and collision masks for player node
        player.physicsBody?.categoryBitMask = playerCol
        player.physicsBody?.collisionBitMask = topCol | rightCol | bottomCol | leftCol | diagonalTopLeftCol | diagonalTopRightCol | diagonalBottomLeftCol | diagonalBottomRightCol | obstacle | traceCol
        player.physicsBody?.contactTestBitMask = topCol | rightCol | bottomCol | leftCol | diagonalTopLeftCol | diagonalTopRightCol | diagonalBottomLeftCol | diagonalBottomRightCol | obstacle | traceCol
        
        joystick.position = CGPoint(x: -500, y: -225)
        joystick.zPosition = 2
        
        //Add physics to player instance
        player.position = CGPoint(x: 0, y: 0)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        //Camera node properties
        cameraNode.position = CGPoint(x: 2500, y: 170)
        self.camera = cameraNode
        addChild(cameraNode)
        
        //Append joystick and player to cameraNode as a child
        cameraNode.addChild(joystick)
        cameraNode.addChild(player)
        
        joystick.delegate = self
        
        //Add timer label
        timerLabel = SKLabelNode(fontNamed: "Helvetica")
        timerLabel.fontSize = 24
        timerLabel.fontColor = SKColor.white
        timerLabel.position = CGPoint(x: 0, y: -200)
        timerLabel.text = "Time: \(countdown)"
        cameraNode.addChild(timerLabel)
        
        //Add play button
        let playButton = SKLabelNode(fontNamed: "Helvetica")
        playButton.text = "Play"
        playButton.fontSize = 24
        playButton.fontColor = SKColor.green
        playButton.position = CGPoint(x: 0, y: 0)
        playButton.name = "playButton"
        cameraNode.addChild(playButton)
        
        //Add trace button
        traceButton.accessibilityIdentifier = "traceButton"
        traceButton.addTarget(self, action: #selector(traceButtonPressed), for: .touchUpInside)
        self.view?.addSubview(traceButton)
        traceButton.frame = CGRect(x: 600, y: 270, width: 100, height: 100)
        traceButton.isHidden = true
        
        //Set image for trace button
        if let buttonImage = UIImage(named: "ActionButton.svg") {
            traceButton.setImage(buttonImage, for: .normal)
        }
        
        //Add walls to the scene
        setupWalls()
    }
    
    @objc func traceButtonPressed() {
        hideTrace()
        if let gameViewController = self.view?.window?.rootViewController as? GameViewController {
            gameViewController.transitionToMiniGameScene()
        }
    }
    
    //Add walls to the map
    func setupWalls() {
        // Room 1_1
        room1_1.position = CGPoint(x: -35, y: 30)
        room1_1.physicsBody?.isDynamic = false
        addChild(room1_1)
        
        //Room 1_2
        room1_2.position = CGPoint(x: 175, y: 339)
        room1_2.physicsBody?.isDynamic = false
        addChild(room1_2)
        
        //Room 1_3
        room1_3.position = CGPoint(x: 385, y: 259)
        room1_3.physicsBody?.isDynamic = false
        addChild(room1_3)
        
        //Hallway 1_1
        hallway1_1.position = CGPoint(x: 448, y: 184)
        hallway1_1.physicsBody?.isDynamic = false
        addChild(hallway1_1)
        
        //Room 1_4
        room1_4.position = CGPoint(x: 385, y: -246)
        room1_4.physicsBody?.isDynamic = false
        addChild(room1_4)
        
        //Room 1_5
        room1_5.position = CGPoint(x: 175, y: -358)
        room1_5.physicsBody?.isDynamic = false
        addChild(room1_5)
        
        //Hallway 1_2
        hallway1_2.position = CGPoint(x: 448, y: -140)
        hallway1_2.physicsBody?.isDynamic = false
        addChild(hallway1_2)
        
        //Partition 2_1
        partition2_1.position = CGPoint(x: 766, y: -137)
        partition2_1.physicsBody?.isDynamic = false
        partition2_1.xScale = 1.85
        partition2_1.yScale = 1.85
        addChild(partition2_1)
        lineLeft21.physicsBody?.isDynamic = false
        self.addChild(lineLeft21)
        lineTop21.physicsBody?.isDynamic = false
        self.addChild(lineTop21)
        lineRight21.physicsBody?.isDynamic = false
        self.addChild(lineRight21)
        
        //Partition 2_2
        partition2_2.position = CGPoint(x: 1005, y: 142)
        partition2_2.physicsBody?.isDynamic = false
        partition2_2.xScale = 1.85
        partition2_2.yScale = 1.85
        addChild(partition2_2)
        lineLeft22.physicsBody?.isDynamic = false
        self.addChild(lineLeft22)
        lineBottom22.physicsBody?.isDynamic = false
        self.addChild(lineBottom22)
        lineRight22.physicsBody?.isDynamic = false
        self.addChild(lineRight22)
        
        //Partition 2_3
        partition2_3.position = CGPoint(x: 1580, y: -180)
        partition2_3.physicsBody?.isDynamic = false
        partition2_3.xScale = 1.85
        partition2_3.yScale = 2.6
        addChild(partition2_3)
        lineLeft23.physicsBody?.isDynamic = false
        self.addChild(lineLeft23)
        lineTop23.physicsBody?.isDynamic = false
        self.addChild(lineTop23)
        lineRight23.physicsBody?.isDynamic = false
        self.addChild(lineRight23)
        
        //Partition 2_4
        partition2_4.position = CGPoint(x: 1840, y: 160)
        partition2_4.physicsBody?.isDynamic = false
        partition2_4.zPosition = 200
        partition2_4.xScale = 1.85
        partition2_4.yScale = 1.85
        addChild(partition2_4)
        lineLeft24.physicsBody?.isDynamic = false
        self.addChild(lineLeft24)
        lineBottom22.physicsBody?.isDynamic = false
        self.addChild(lineBottom24)
        lineRight24.physicsBody?.isDynamic = false
        self.addChild(lineRight24)
        
        //Room 2_1
        room2_1.position = CGPoint(x: 511, y: 259)
        room2_1.physicsBody?.isDynamic = false
        addChild(room2_1)
        
        //Room 2_2
        room2_2.position = CGPoint(x: 766, y: 345)
        room2_2.physicsBody?.isDynamic = false
        addChild(room2_2)
        
        //Room 2_3
        room2_3.position = CGPoint(x: 1005, y: 401)
        room2_3.physicsBody?.isDynamic = false
        addChild(room2_3)
        
        //Room 2_4
        room2_4.position = CGPoint(x: 1104, y: 506)
        room2_4.physicsBody?.isDynamic = false
        addChild(room2_4)
        
        //Room 2_5
        room2_5.position = CGPoint(x: 1297, y: 562)
        room2_5.physicsBody?.isDynamic = false
        addChild(room2_5)
        
        //Room 2_6
        room2_6.position = CGPoint(x: 1484, y: 506)
        room2_6.physicsBody?.isDynamic = false
        addChild(room2_6)
        
        //Room 2_7
        room2_7.position = CGPoint(x: 1581, y: 404)
        room2_7.physicsBody?.isDynamic = false
        addChild(room2_7)
        
        //Room 2_8
        room2_8.position = CGPoint(x: 1820, y: 347)
        room2_8.physicsBody?.isDynamic = false
        addChild(room2_8)
        
        //Room 2_9
        room2_9.position = CGPoint(x: 2076, y: 245)
        room2_9.physicsBody?.isDynamic = false
        addChild(room2_9)
        
        //Hallway 2_1
        hallway2_1.position = CGPoint(x: 2139, y: 153)
        hallway2_1.physicsBody?.isDynamic = false
        addChild(hallway2_1)
        
        //Hallway 2_2
        hallway2_2.position = CGPoint(x: 2138, y: -180)
        hallway2_2.physicsBody?.isDynamic = false
        addChild(hallway2_2)
        
        //Room 2_10
        room2_10.position = CGPoint(x: 2084, y: -270)
        room2_10.physicsBody?.isDynamic = false
        addChild(room2_10)
        
        //Room 2_11
        room2_11.position = CGPoint(x: 1828, y: -370)
        room2_11.physicsBody?.isDynamic = false
        addChild(room2_11)
        
        //Room 2_12
        room2_12.position = CGPoint(x: 1580, y: -422)
        room2_12.physicsBody?.isDynamic = false
        addChild(room2_12)
        
        //Room 2_13
        room2_13.position = CGPoint(x: 1482, y: -525)
        room2_13.physicsBody?.isDynamic = false
        addChild(room2_13)
        
        //Room 2_14
        room2_14.position = CGPoint(x: 1295, y: -573)
        room2_14.physicsBody?.isDynamic = false
        addChild(room2_14)
        
        //Room 2_15
        room2_15.position = CGPoint(x: 1103, y: -524)
        room2_15.physicsBody?.isDynamic = false
        addChild(room2_15)
        
        //Room 2_16
        room2_16.position = CGPoint(x: 1005, y: -420)
        room2_16.physicsBody?.isDynamic = false
        addChild(room2_16)
        
        //Room 2_17
        room2_17.position = CGPoint(x: 766, y: -372)
        room2_17.physicsBody?.isDynamic = false
        addChild(room2_17)
        
        //Room 2_18
        room2_18.position = CGPoint(x: 511, y: -251)
        room2_18.physicsBody?.isDynamic = false
        addChild(room2_18)
        
        //Room 3_1
        room3_1.position = CGPoint(x: 2185, y: 256)
        room3_1.physicsBody?.isDynamic = false
        addChild(room3_1)
        
        //Room 3_2
        room3_2.position = CGPoint(x: 2283, y: 419)
        room3_2.physicsBody?.isDynamic = false
        addChild(room3_2)
        
        //Room 3_3
        room3_3.position = CGPoint(x: 2443, y: 509)
        room3_3.physicsBody?.isDynamic = false
        addChild(room3_3)
        
        //Room 3_4
        room3_4.position = CGPoint(x: 2619, y: 532)
        room3_4.physicsBody?.isDynamic = false
        addChild(room3_4)
        
        //Room 3_5
        room3_5.position = CGPoint(x: 2795, y: 509)
        room3_5.physicsBody?.isDynamic = false
        addChild(room3_5)
        
        //Room 3_6
        room3_6.position = CGPoint(x: 2955, y: 418)
        room3_6.physicsBody?.isDynamic = false
        addChild(room3_6)
        
        //Room 3_7
        room3_7.position = CGPoint(x: 3052, y: -69)
        room3_7.physicsBody?.isDynamic = false
        addChild(room3_7)
        
        //Room 3_8
        room3_8.position = CGPoint(x: 2618, y: -580)
        room3_8.physicsBody?.isDynamic = false
        addChild(room3_8)
        
        //Room 3_9
        room3_9.position = CGPoint(x: 2184  , y: -381)
        room3_9.physicsBody?.isDynamic = false
        addChild(room3_9)
        
        //Partition Main
        partitionMain.position = CGPoint(x: 2619  , y: 410)
        partitionMain.physicsBody?.isDynamic = false
        partitionMain.zPosition = 5
        addChild(partitionMain)
        
        //Set trace line
        traceLine.physicsBody?.isDynamic = false
        self.addChild(traceLine)
        
        //Painting
        painting.position = CGPoint(x: 0, y: 0)
        painting.zPosition = 6
        painting.xScale = 2
        painting.yScale = 2
        partitionMain.addChild(painting)
        
        //Partition Left
        partitionLeft.position = CGPoint(x: 2500, y: 100)
        partitionLeft.xScale = 1.85
        partitionRight.yScale = 1.85
        addChild(partitionLeft)
        
        //Partition Right
    }
    
    //Handling collision response
    func didBegin(_ contact: SKPhysicsContact) {
        //Add response later eg. sound effects
        if contact.bodyA.categoryBitMask == 0b1 || contact.bodyB.categoryBitMask == 0b1 {
            handleCollision(contact: contact)
            
            return
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if (firstBody.categoryBitMask == playerCol && secondBody.categoryBitMask == traceCol) ||
        (firstBody.categoryBitMask == traceCol && secondBody.categoryBitMask == playerCol) {
         isTriggeringTrace = false
         hideTrace()
     }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self.view)
            if let touchedView = self.view?.hitTest(location, with: event) {
                if touchedView is UIButton, let button = touchedView as? UIButton, button.accessibilityIdentifier == "traceButton" {
                    traceButtonPressed()
                } else if let touchedNode = self.atPoint(location) as? SKNode {
                    if touchedNode.name == "playButton" {
                        startTimer()
                    } else if touchedNode.name == "retryButton" {
                        resetGame()
                    } else {
                        joystick.moveJoystick(touch: touch)
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            joystick.moveJoystick(touch: touch)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        joystick.resetJoystick()
    }
    
    func joystickMoved(to direction: CGPoint) {
        let cameraMovement = CGPoint(x: direction.x * 10, y: direction.y * 10)
        
        if isTouchingTop {
            cameraNode.position.y -= 5
            isTouchingTop = false
            isPlayerTouchingBorder = false
        } else if isTouchingRight {
            cameraNode.position.x -= 5
            isTouchingRight = false
            isPlayerTouchingBorder = false
        } else if isTouchingBottom {
            cameraNode.position.y += 5
            isTouchingBottom = false
            isPlayerTouchingBorder = false
        } else if isTouchingLeft {
            cameraNode.position.x += 5
            isTouchingLeft = false
            isPlayerTouchingBorder = false
        } else if isTouchingDiagonalTopLeft {
            cameraNode.position.x += 5
            cameraNode.position.y -= 5
            isTouchingDiagonalTopLeft = false
            isPlayerTouchingBorder = false
        } else if isTouchingDiagonalTopRight {
            cameraNode.position.x -= 5
            cameraNode.position.y -= 5
            isTouchingDiagonalTopRight = false
            isPlayerTouchingBorder = false
        } else if isTouchingDiagonalBottomRight {
            cameraNode.position.x -= 5
            cameraNode.position.y += 5
            isTouchingDiagonalBottomRight = false
            isPlayerTouchingBorder = false
        } else if isTouchingDiagonalBottomLeft {
            cameraNode.position.x += 5
            cameraNode.position.y += 5
            isTouchingDiagonalBottomLeft = false
            isPlayerTouchingBorder = false
        } else if isTriggeringTrace {
            showTrace()
            cameraNode.position.x += cameraMovement.x
            cameraNode.position.y += cameraMovement.y
        } else {
            cameraNode.position.x += cameraMovement.x
            cameraNode.position.y += cameraMovement.y
            hideTrace()
        }
    }
    
    func handleCollision(contact: SKPhysicsContact) {
        //Determining which body is the player
        let playerBody: SKPhysicsBody
        let otherBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask == playerCol {
            playerBody = contact.bodyA
            otherBody = contact.bodyB
        } else {
            playerBody = contact.bodyB
            otherBody = contact.bodyA
        }
        
        switch otherBody.categoryBitMask {
        case topCol:
            isPlayerTouchingBorder = true
            isTouchingTop = true
        case bottomCol:
            isPlayerTouchingBorder = true
            isTouchingBottom = true
        case rightCol:
            isPlayerTouchingBorder = true
            isTouchingRight = true
        case leftCol:
            isPlayerTouchingBorder = true
            isTouchingLeft = true
        case diagonalTopLeftCol:
            isPlayerTouchingBorder = true
            isTouchingDiagonalTopLeft = true
        case diagonalTopRightCol:
            isPlayerTouchingBorder = true
            isTouchingDiagonalTopRight = true
        case diagonalBottomLeftCol:
            isPlayerTouchingBorder = true
            isTouchingDiagonalBottomLeft = true
        case diagonalBottomRightCol:
            isPlayerTouchingBorder = true
            isTouchingDiagonalBottomRight = true
        case obstacle:
            gameOver()
        case traceCol:
            isTriggeringTrace = true
        default:
            break
        }
    }
    
    
    
    func startTimer() {
        if !isTimerRunning {
            isTimerRunning = true
            let wait = SKAction.wait(forDuration: 1)
            let action = SKAction.run { [weak self] in
                self?.updateTimer()
            }
            let sequence = SKAction.sequence([wait, action])
            let repeatAction = SKAction.repeatForever(sequence)
            run(repeatAction, withKey: "timer")
        }
    }
    
    func updateTimer() {
        if countdown > 0 {
            countdown -= 1
            timerLabel.text = "Time: \(countdown)"
        } else {
            gameOver()
            removeAction(forKey: "timer")
            
            //Handle timer end (add game over later)
        }
    }
    
    func gameOver() {
        //Stops the timer
        isTimerRunning = false
        removeAllActions()
    
        gameOverLabel.fontSize = 60
        gameOverLabel.fontColor = SKColor.red
        gameOverLabel.position = CGPoint(x: 0, y: 0)
        gameOverLabel.zPosition = 200
        gameOverLabel.text = "Game Over"
        gameOverLabel.name = "gameOver"
        gameOverLabel.removeFromParent()
        cameraNode.addChild(gameOverLabel)
        
        retryButton.fontSize = 40
        retryButton.fontColor = SKColor.green
        retryButton.position = CGPoint(x: 0, y: -50)
        retryButton.zPosition = 201
        retryButton.text = "Retry"
        retryButton.name = "retryButton"
        retryButton.removeFromParent()
        cameraNode.addChild(retryButton)
    }
    
    func resetGame() {
        //Resets player position
        player.position = CGPoint(x: 0, y: 0)
        joystick.resetJoystick()
        
        //Resets camera position
        cameraNode.position = CGPoint(x: 0, y: 0)
        
        //Resets timer
        countdown = 120
        timerLabel.text = "Time: \(countdown)"
        
        //Remove game over screen elements
        gameOverLabel.removeFromParent()
        retryButton.removeFromParent()
        
        //Reset game state
        isTimerRunning = false
        startTimer()
        
        print("game reset")
    }
    
    func hideTrace() {
        print("hide trace called")
        traceButton.isHidden = true
    }
    
    func showTrace() {
        traceButton.isHidden = false
    }
}

class Bear: SKSpriteNode {
    init() {
        // Load the image from your asset catalog
        let texture = SKTexture(imageNamed: "guard") // Replace "Bear" with the name of your image asset
        let originalSize = texture.size()
        let scaledSize = CGSize(width: originalSize.width, height: originalSize.height)
        
        // Initialize the sprite node with the texture
        super.init(texture: texture, color: .clear, size: scaledSize)
        
        // Set up physics body
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody.isDynamic = false // Set to true if you want it to interact with other dynamic bodies
        self.physicsBody = physicsBody
        self.physicsBody?.categoryBitMask = obstacle
        self.physicsBody?.collisionBitMask = playerCol
        
        // Set other properties as needed
        name = "enemyBear"
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Guard: SKSpriteNode {
    init() {
        // Load the image from your asset catalog
        let texture = SKTexture(imageNamed: "guard") // Replace "Bear" with the name of your image asset
        let originalSize = texture.size()
        let scaledSize = CGSize(width: originalSize.width*2, height: originalSize.height*2)
        
        // Initialize the sprite node with the texture
        super.init(texture: texture, color: .clear, size: scaledSize)
        
        // Set up physics body
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody.isDynamic = false // Set to true if you want it to interact with other dynamic bodies
        self.physicsBody = physicsBody
        self.physicsBody?.categoryBitMask = obstacle
        self.physicsBody?.collisionBitMask = playerCol
        
        // Set other properties as needed
        name = "enemyBear"
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GuardTrack: SKNode {
    override init() {
        super.init()

        let bear = Bear()
        bear.setScale(2)
                    
        self.addChild(bear)
        
        let moveRight = SKAction.moveBy(x: 500, y: 2, duration: 4)
        let moveUp = SKAction.moveBy(x: 0, y: 250, duration: 3)
        let moveLeft = SKAction.moveBy(x: -500, y: 2, duration: 4)
        let moveDown = SKAction.moveBy(x: 0, y: -250, duration: 3)
        
        let flipHorizontallyRight = SKAction.run { bear.xScale = -2.0 }
        let flipHorizontallyLeft = SKAction.run { bear.xScale = 2.0 }
        
         
        // Create a sequence of actions with flipping included
        let sequence = SKAction.sequence([
            moveLeft,
            moveUp,
            flipHorizontallyRight,
            moveRight,
            moveDown,
            flipHorizontallyLeft
        ])
        
        let repeatForever = SKAction.repeatForever(sequence)
        bear.run(repeatForever)


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

