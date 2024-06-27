//
//  EndGameScene.swift
//  RobberyGame
//
//  Created by James Cellars on 24/06/24.
//

import SpriteKit
import GameplayKit
import GameKit
import Foundation

class EndGameScene: SKScene, SneakyJoystickDelegate, SKPhysicsContactDelegate {
    
    var match: GKMatch?
    var player1: Cat!
    var player2: Fox!
    
    //Creates and displays game over screen
    let gameOverImage = SKSpriteNode(imageNamed: "BustedPopup.svg")
    
    //Retry button
    let retryButton = SKSpriteNode(imageNamed: "replayButtonDefault.svg")
    
    //Black screen for game over background
    let blackScreen = SKSpriteNode(color: .black, size: CGSize(width: 1500, height: 1000))
    
    //Win screen
    let winScreen = SKSpriteNode(imageNamed: "SuccessPopup.svg")
    
    //Back to home button after winning
    let homeButton = SKSpriteNode(imageNamed: "homeButtonDefault.svg")
    
    //Trace button
    let traceButton = UIButton(type: .custom)
    
    //Electrical button
    let electricButton = UIButton(type: .custom)
    
    //Start multiplayer
    func playerSetUp(with match: GKMatch) {
        self.match = match
        print("match")
            
        // Set up player 1 and player 2
//        let player1Texture = SKTexture(imageNamed: "playerOne.png")
//        player1 = Player(playerName: "Player 1", texture: player1Texture)
        player1.position = CGPoint(x: size.width * 0.2, y: size.height / 2)
        player1 = Cat()
        addChild(player1)
        print("Player One initiated")
        
//        let player2Texture = SKTexture(imageNamed: "playerTwo.png")
//        player2 = Player(playerName: "Player 2", texture: player2Texture)
        player2 = Fox()
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
    let player = Fox()
    
    //Create camera node
    let cameraNode = SKCameraNode()
    
    //Reference to GameViewController
    weak var gameViewController: GameViewController?
    
    //Win mechanic conditional
    let cctv1 = CCTVTop()
    let cctv2 = CCTVDown()
    let cctv3 = CCTVTop()
    let cctv4 = CCTVDown()
    let cctvPainting = CCTVTop()
    let range1 = CCTVRange()
    let range2 = CCTVRange()
    let range3 = CCTVRange()
    let range4 = CCTVRange()
    let rangePainting = CCTVRange()
    let bear = Bear()
    let track = GuardTrack()
    
    // Interior Design
    let stairs = SKSpriteNode(imageNamed: "Staircase")
    let statue_cat = SKSpriteNode(imageNamed: "statue_cat")
    let decor_top = SKSpriteNode(imageNamed: "Decor-Top")
    let decor_mid = SKSpriteNode(imageNamed: "Decor-Mid")
    let decor_down = SKSpriteNode(imageNamed: "Decor-Down")
    
    //Game walls
    let room1_1 = SKSpriteNode(imageNamed: "room1_1New.png")
    let room1_2 = SKSpriteNode(imageNamed: "room1_2New.png")
    let room1_3 = SKSpriteNode(imageNamed: "room1_3New.png")
    let hallway1_1 = SKSpriteNode(imageNamed: "hallway1_1New.png")
    let hallway1_2 = SKSpriteNode(imageNamed: "hallway1_2New.png")
    let room1_4 = SKSpriteNode(imageNamed: "room1_4New.png")
    let room1_5 = SKSpriteNode(imageNamed: "room1_5New.png")
    
    let partition2_1 = SKSpriteNode(imageNamed: "partitionwall2_1")
    let partition2_2 = SKSpriteNode(imageNamed: "partitionwall2_2")
    let partition2_3 = SKSpriteNode(imageNamed: "partitionwall2_3")
    let partition2_4 = SKSpriteNode(imageNamed: "partitionwall2_4")
    let partitionMain = SKSpriteNode(imageNamed: "partitionMain.png")
    let partitionLeft = SKSpriteNode(imageNamed: "partitionLeft.png")
    let partitionRight = SKSpriteNode(imageNamed: "partitionRight.png")
    
    let leftStandingBarrier = SKSpriteNode(imageNamed: "leftStandingBarrier.png")
    let rightStandingBarrier = SKSpriteNode(imageNamed: "rightStandingBarrier.png")
    
    //Exit
    let exitOpened = SKSpriteNode(imageNamed: "exitOpened.png")
    
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
    
    let lineBottom31 = SKShapeNode()
    let lineRight31 = SKShapeNode()
    let lineTop31 = SKShapeNode()
    let lineBottom32 = SKShapeNode()
    let lineLeft32 = SKShapeNode()
    let lineTop32 = SKShapeNode()
    
    let bottomElectricLine = SKShapeNode()
    
    let bottomLineBarrier1 = SKShapeNode()
    let rightLineBarrier1 = SKShapeNode()
    let bottomLineBarrier2 = SKShapeNode()
    let leftLineBarrier2 = SKShapeNode()
    
    let room2_1 = SKSpriteNode(imageNamed: "room2_1New.png")
    let room2_2 = SKSpriteNode(imageNamed: "room2_2New.png")
    let room2_3 = SKSpriteNode(imageNamed: "room2_3New.png")
    let room2_4 = SKSpriteNode(imageNamed: "room2_4New.png")
    let room2_5 = SKSpriteNode(imageNamed: "room2_5New.png")
    let room2_6 = SKSpriteNode(imageNamed: "room2_6New.png")
    let room2_7 = SKSpriteNode(imageNamed: "room2_7New.png")
    let room2_8 = SKSpriteNode(imageNamed: "room2_8New.png")
    let room2_9 = SKSpriteNode(imageNamed: "room2_9New.png")
    let hallway2_1 = SKSpriteNode(imageNamed: "hallway2_1New.png")
    let hallway2_2 = SKSpriteNode(imageNamed: "hallway2_2New.png")
    let room2_10 = SKSpriteNode(imageNamed: "room2_10New.png")
    let room2_11 = SKSpriteNode(imageNamed: "room2_11New.png")
    let room2_12 = SKSpriteNode(imageNamed: "room2_12New.png")
    let room2_13 = SKSpriteNode(imageNamed: "room2_13New.png")
    let room2_14 = SKSpriteNode(imageNamed: "room2_14New.png")
    let room2_15 = SKSpriteNode(imageNamed: "room2_15New.png")
    let room2_16 = SKSpriteNode(imageNamed: "room2_16New.png")
    let room2_17 = SKSpriteNode(imageNamed: "room2_17New.png")
    let room2_18 = SKSpriteNode(imageNamed: "room2_18New.png")
    
    let room3_1 = SKSpriteNode(imageNamed: "room3_1New.png")
    let room3_2 = SKSpriteNode(imageNamed: "room3_2New.png")
    let room3_3 = SKSpriteNode(imageNamed: "room3_3New.png")
    let room3_4 = SKSpriteNode(imageNamed: "room3_4New.png")
    let room3_5 = SKSpriteNode(imageNamed: "room3_5New.png")
    let room3_6 = SKSpriteNode(imageNamed: "room3_6New.png")
    let room3_7 = SKSpriteNode(imageNamed: "room3_7New.png")
    let room3_8 = SKSpriteNode(imageNamed: "room3_8New.png")
    let room3_9 = SKSpriteNode(imageNamed: "room3_9New.png")
    
    //Interactable items
    let painting = SKSpriteNode(imageNamed: "MonaLisa")
    let offElectricalBox = SKSpriteNode(imageNamed: "off_ElectricalBox.png")
    let onElectricalBox = SKSpriteNode(imageNamed: "on_ElectricalBox.png")
    let offLaser = SKSpriteNode(imageNamed: "off_Laser.png")
    let onLaser = SKSpriteNode(imageNamed: "on_Laser.png")
    
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
    var isTriggeringElectrical = false
    
    //Timer properties
    var timerLabel: SKLabelNode!
    var countdown: Int = 120
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
        
            lineBottom31.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 2200, y: -420), to: CGPoint(x: 2458, y: -420))
            lineBottom31.physicsBody?.categoryBitMask = topCol
            lineBottom31.physicsBody?.collisionBitMask = playerCol
            
            lineRight31.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 2458, y: -420), to: CGPoint(x: 2458, y: -235))
            lineRight31.physicsBody?.categoryBitMask = leftCol
            lineRight31.physicsBody?.collisionBitMask = playerCol
            
            lineTop31.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 2458, y: -235), to: CGPoint(x: 2200, y: -235))
            lineTop31.physicsBody?.categoryBitMask = bottomCol
            lineTop31.physicsBody?.collisionBitMask = playerCol
        
            lineBottom32.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 2755, y: -420), to: CGPoint(x: 3050, y: -420))
            lineBottom32.physicsBody?.categoryBitMask = topCol
            lineBottom32.physicsBody?.collisionBitMask = playerCol
            
            lineLeft32.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 2755, y: -420), to: CGPoint(x: 2755, y: -240))
            lineLeft32.physicsBody?.categoryBitMask = rightCol
            lineLeft32.physicsBody?.collisionBitMask = playerCol
            
            lineTop32.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 2755, y: -240), to: CGPoint(x: 3050, y: -240))
            lineTop32.physicsBody?.categoryBitMask = bottomCol
            lineTop32.physicsBody?.collisionBitMask = playerCol
            
            bottomElectricLine.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 2280, y: -450), to: CGPoint(x: 2380, y: -450))
            bottomElectricLine.physicsBody?.categoryBitMask = electricCol
            bottomElectricLine.physicsBody?.collisionBitMask = playerCol
        
            onLaser.physicsBody = SKPhysicsBody(texture: onLaser.texture!, size: onLaser.size)
            onLaser.physicsBody?.categoryBitMask = obstacle
            onLaser.physicsBody?.collisionBitMask = playerCol
            
            cctvPainting.zPosition = 3
            cctvPainting.position = CGPoint(x: 0, y: 100)
            partitionMain.addChild(cctvPainting)
            cctvPainting.addChild(rangePainting)
            
            rangePainting.physicsBody?.categoryBitMask = obstacle
            rangePainting.physicsBody?.collisionBitMask = playerCol
        
            //Barriers
            addChild(leftStandingBarrier)
            leftStandingBarrier.position = CGPoint(x: 2340, y: 170)
            leftStandingBarrier.xScale = 2.0
            leftStandingBarrier.yScale = 2.0
            
            addChild(rightStandingBarrier)
            rightStandingBarrier.position = CGPoint(x: 2890, y: 170)
            
            addChild(bottomLineBarrier1)
            bottomLineBarrier1.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 2220, y: 60), to: CGPoint(x: 2458, y: 60))
            bottomLineBarrier1.physicsBody?.categoryBitMask = topCol
            bottomLineBarrier1.physicsBody?.collisionBitMask = playerCol
            
            addChild(rightLineBarrier1)
            rightLineBarrier1.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 2458, y: 60), to: CGPoint(x: 2458, y: 300))
            rightLineBarrier1.physicsBody?.categoryBitMask = leftCol
            rightLineBarrier1.physicsBody?.collisionBitMask = playerCol
            
            addChild(bottomLineBarrier2)
            bottomLineBarrier2.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 2770, y: 60), to: CGPoint(x: 3050, y: 60))
            bottomLineBarrier2.physicsBody?.categoryBitMask = topCol
            bottomLineBarrier2.physicsBody?.collisionBitMask = playerCol
            
            addChild(leftLineBarrier2)
            leftLineBarrier2.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 2770, y: 60), to: CGPoint(x: 2770, y: 300))
            leftLineBarrier2.physicsBody?.categoryBitMask = rightCol
            leftLineBarrier2.physicsBody?.collisionBitMask = playerCol
        
        let playerTexture = SKTexture(imageNamed: "Cat_Idle_1")
        let textureSize = playerTexture.size()
        
        //Create physics body for player
        player.physicsBody = SKPhysicsBody(texture: playerTexture, size: textureSize)
        
        //Category and collision masks for player node
        player.physicsBody?.categoryBitMask = playerCol
        player.physicsBody?.collisionBitMask = topCol | rightCol | bottomCol | leftCol | diagonalTopLeftCol | diagonalTopRightCol | diagonalBottomLeftCol | diagonalBottomRightCol | obstacle | traceCol | electricCol | winCol
        player.physicsBody?.contactTestBitMask = topCol | rightCol | bottomCol | leftCol | diagonalTopLeftCol | diagonalTopRightCol | diagonalBottomLeftCol | diagonalBottomRightCol | obstacle | traceCol | electricCol | winCol
        
        joystick.position = CGPoint(x: -500, y: -225)
        joystick.zPosition = 2
        
        //Add physics to player instance
        player.position = CGPoint(x: 0, y: 0)
        player.zPosition = 10
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        //Camera node properties
        cameraNode.position = CGPoint(x: 0, y: 0)
        self.camera = cameraNode
        cameraNode.setScale(0.5)
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
        
        //Add electrical button
        electricButton.accessibilityIdentifier = "electricButton"
        electricButton.addTarget(self, action: #selector(electricButtonPressed), for: .touchUpInside)
        self.view?.addSubview(electricButton)
        electricButton.frame = CGRect(x: 600, y: 270, width: 100, height: 100)
        electricButton.isHidden = true
        
        //Set image for trace button
        if let buttonImage = UIImage(named: "ActionButton.svg") {
            electricButton.setImage(buttonImage, for: .normal)
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
    
    @objc func electricButtonPressed() {
        if onElectricalBox.isHidden == false {
            electricOff()
            offLasers()
        } else if onElectricalBox.isHidden == true {
            electricOn()
            onLasers()
        }
    }
    
    @objc func goHome() {
        if let gameViewController = self.view?.window?.rootViewController as? GameViewController {
            gameViewController.transitionToStartScene()
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
        
        //Staircase
        addChild(stairs)
        stairs.position = CGPoint(x: 300, y: -50)
        
        var stairLeft1 = SKShapeNode()
        addChild(stairLeft1)
        stairLeft1.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 200, y: 50), to: CGPoint(x: 200, y: 150))
        stairLeft1.physicsBody?.categoryBitMask = rightCol
        stairLeft1.physicsBody?.collisionBitMask = playerCol
        
        var stairTop1 = SKShapeNode()
        addChild(stairTop1)
        stairTop1.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 200, y: 145), to: CGPoint(x: 385, y: 210))
        stairTop1.physicsBody?.categoryBitMask = bottomCol
        stairTop1.physicsBody?.collisionBitMask = playerCol
        
        var stairBottom1 = SKShapeNode()
        addChild(stairBottom1)
        stairBottom1.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 200, y: 50), to: CGPoint(x: 385, y: 115))
        stairBottom1.physicsBody?.categoryBitMask = topCol
        stairBottom1.physicsBody?.collisionBitMask = playerCol
        
        var stairLeft2 = SKShapeNode()
        addChild(stairLeft2)
        stairLeft2.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 200, y: -300), to: CGPoint(x: 200, y: -215))
        stairLeft2.physicsBody?.categoryBitMask = rightCol
        stairLeft2.physicsBody?.collisionBitMask = playerCol
        
        var stairTop2 = SKShapeNode()
        addChild(stairTop2)
        stairTop2.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 200, y: -215), to: CGPoint(x: 385, y: -150))
        stairTop2.physicsBody?.categoryBitMask = bottomCol
        stairTop2.physicsBody?.collisionBitMask = playerCol
        
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
        
        //Cat statue
        addChild(statue_cat)
        statue_cat.position = CGPoint(x: 958, y: 0)
        statue_cat.setScale(2)
        statue_cat.zPosition = 11
        
        var catBottomLine = SKShapeNode()
        addChild(catBottomLine)
        catBottomLine.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 920, y: -75), to: CGPoint(x: 990, y: -75))
        catBottomLine.physicsBody?.categoryBitMask = topCol
        catBottomLine.physicsBody?.collisionBitMask = playerCol
        
        var catLeftLine = SKShapeNode()
        addChild(catLeftLine)
        catLeftLine.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 920, y: -75), to: CGPoint(x: 920, y: 10))
        catLeftLine.physicsBody?.categoryBitMask = rightCol
        catLeftLine.physicsBody?.collisionBitMask = playerCol
        
        var catTopLine = SKShapeNode()
        addChild(catTopLine)
        catTopLine.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 920, y: 10), to: CGPoint(x: 990, y: 10))
        catTopLine.physicsBody?.categoryBitMask = bottomCol
        catTopLine.physicsBody?.collisionBitMask = playerCol
        
        //Room 2_3
        room2_3.position = CGPoint(x: 1005, y: 401)
        room2_3.physicsBody?.isDynamic = false
        addChild(room2_3)
        
        //Room 2_4
        room2_4.position = CGPoint(x: 1104, y: 506)
        room2_4.physicsBody?.isDynamic = false
        addChild(room2_4)
        
        //Decor Top
           addChild(decor_top)
           decor_top.zPosition = 2
           decor_top.position = CGPoint(x: 1297, y: 400)
           decor_top.setScale(2)
        
        var topDecorBottom1 = SKShapeNode()
        addChild(topDecorBottom1)
        topDecorBottom1.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1100, y: 325), to: CGPoint(x: 1300, y: 275))
        topDecorBottom1.physicsBody?.categoryBitMask = topCol
        topDecorBottom1.physicsBody?.collisionBitMask = playerCol
        
        var topDecorLeft = SKShapeNode()
        addChild(topDecorLeft)
        topDecorLeft.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1100, y: 325), to: CGPoint(x: 1100, y: 400))
        topDecorLeft.physicsBody?.categoryBitMask = rightCol
        topDecorLeft.physicsBody?.collisionBitMask = playerCol
        
        var topDecorBottom2 = SKShapeNode()
        addChild(topDecorBottom2)
        topDecorBottom2.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1300, y: 275), to: CGPoint(x: 1500, y: 325))
        topDecorBottom2.physicsBody?.categoryBitMask = topCol
        topDecorBottom2.physicsBody?.collisionBitMask = playerCol
        
        var topDecorRight = SKShapeNode()
        addChild(topDecorRight)
        topDecorRight.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1500, y: 325), to: CGPoint(x: 1500, y: 400))
        topDecorRight.physicsBody?.categoryBitMask = leftCol
        topDecorRight.physicsBody?.collisionBitMask = playerCol
        
        
           //Decor Mid
           addChild(decor_mid)
           decor_mid.zPosition = 2
           decor_mid.position = CGPoint(x: 1297, y: 20)
           decor_mid.setScale(2)
        
        var midDecorBottom = SKShapeNode()
        addChild(midDecorBottom)
        midDecorBottom.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1130, y: -100), to: CGPoint(x: 1470, y: -100))
        midDecorBottom.physicsBody?.categoryBitMask = topCol
        midDecorBottom.physicsBody?.collisionBitMask = playerCol
        
        var midDecorRight = SKShapeNode()
        addChild(midDecorRight)
        midDecorRight.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1470, y: -100), to: CGPoint(x: 1470, y: 140))
        midDecorRight.physicsBody?.categoryBitMask = leftCol
        midDecorRight.physicsBody?.collisionBitMask = playerCol
        
        var midDecorTop = SKShapeNode()
        addChild(midDecorTop)
        midDecorTop.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1470, y: 140), to: CGPoint(x: 1130, y: 140))
        midDecorTop.physicsBody?.categoryBitMask = bottomCol
        midDecorTop.physicsBody?.collisionBitMask = playerCol
        
        var midDecorLeft = SKShapeNode()
        addChild(midDecorLeft)
        midDecorLeft.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1130, y: 140), to: CGPoint(x: 1130, y: -100))
        midDecorLeft.physicsBody?.categoryBitMask = rightCol
        midDecorLeft.physicsBody?.collisionBitMask = playerCol
           
           //Decor Down
           addChild(decor_down)
           decor_down.zPosition = 2
           decor_down.position = CGPoint(x: 1297, y: -375)
           decor_down.setScale(2)
        
        var bottomDecorTop = SKShapeNode()
        addChild(bottomDecorTop)
        bottomDecorTop.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1100, y: -280), to: CGPoint(x: 1500, y: -280))
        bottomDecorTop.physicsBody?.categoryBitMask = bottomCol
        bottomDecorTop.physicsBody?.collisionBitMask = playerCol
        
        var bottomDecorLeft = SKShapeNode()
        addChild(bottomDecorLeft)
        bottomDecorLeft.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1100, y: -280), to: CGPoint(x: 1100, y: -500))
        bottomDecorLeft.physicsBody?.categoryBitMask = rightCol
        bottomDecorLeft.physicsBody?.collisionBitMask = playerCol
        
        var bottomDecorRight = SKShapeNode()
        addChild(bottomDecorRight)
        bottomDecorRight.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 1500, y: -280), to: CGPoint(x: 1500, y: -500))
        bottomDecorRight.physicsBody?.categoryBitMask = leftCol
        bottomDecorRight.physicsBody?.collisionBitMask = playerCol
        
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
        partitionLeft.position = CGPoint(x: 2330, y: -330)
        partitionLeft.xScale = 1.85
        partitionLeft.yScale = 1.85
        addChild(partitionLeft)
        
        //Fuse box
        partitionLeft.addChild(offElectricalBox)
        partitionLeft.addChild(onElectricalBox)
        offElectricalBox.isHidden = true
        onElectricalBox.isHidden = false
        onElectricalBox.zPosition = 10
        offElectricalBox.zPosition = 10
        onElectricalBox.xScale = 0.5
        onElectricalBox.yScale = 0.5
        offElectricalBox.xScale = 1.0
        onElectricalBox.yScale = 0.5
        
        //Lasers
        addChild(offLaser)
        addChild(onLaser)
        offLaser.isHidden = true
        onLaser.position = CGPoint(x: 2619, y: 170)
        onLaser.physicsBody?.isDynamic = false
        offLaser.position = CGPoint(x: 2619, y: 170)
        
        bottomElectricLine.physicsBody?.isDynamic = false
        self.addChild(bottomElectricLine)
        
        //Partition Right
        partitionRight.position = CGPoint(x: 2895, y: -330)
        partitionRight.yScale = 0.90
        addChild(partitionRight)
        
        lineBottom31.physicsBody?.isDynamic = false
        self.addChild(lineBottom31)
        
        lineRight31.physicsBody?.isDynamic = false
        self.addChild(lineRight31)
        
        lineTop31.physicsBody?.isDynamic = false
        self.addChild(lineTop31)
        
        lineBottom32.physicsBody?.isDynamic = false
        self.addChild(lineBottom32)
        
        lineLeft32.physicsBody?.isDynamic = false
        self.addChild(lineLeft32)
        
        lineTop32.physicsBody?.isDynamic = false
        self.addChild(lineTop32)
        
        //Exit
        addChild(exitOpened)
        exitOpened.position = CGPoint(x: 2895, y: -500)
        exitOpened.physicsBody = SKPhysicsBody(texture: exitOpened.texture!, size: exitOpened.size)
        exitOpened.physicsBody?.categoryBitMask = winCol
        exitOpened.physicsBody?.collisionBitMask = playerCol

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
        } else if (firstBody.categoryBitMask == playerCol && secondBody.categoryBitMask == electricCol) || (firstBody.categoryBitMask == electricCol && secondBody.categoryBitMask == playerCol) {
             isTriggeringElectrical = false
             hideElectric()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self.view)

            // Check if the touch hits a UIButton
            if let touchedView = self.view?.hitTest(location, with: event), touchedView is UIButton {
                let button = touchedView as! UIButton
                if button.accessibilityIdentifier == "traceButton" {
                    traceButtonPressed()
                } else if button.accessibilityIdentifier == "electricButton" {
                    electricButtonPressed()
                }
            } else {
                // Convert the touch location to the scene's coordinate space
                let sceneLocation = self.convertPoint(fromView: location)
                let touchedNode = self.atPoint(sceneLocation)

                // Check if the touch hits an SKNode
                if let touchedNode = touchedNode as? SKNode {
                    if touchedNode.name == "retryButton" {
                        print("reset")
                        resetGame()
                    } else if touchedNode.name == "homeButton" {
                        goHome()
                    } else {
                        startTimer()
                        joystick.moveJoystick(touch: touch)
                        onLasers()
                        electricOn()
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
        onLasers()
        electricOn()
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
        } else if isTriggeringElectrical {
            electricButton.isHidden = false
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
        case electricCol:
            isTriggeringElectrical = true
        case winCol:
            win()
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
    
    func win() {
        //Black screen as background for win image
        blackScreen.position = CGPoint(x: 0, y: 0)
        blackScreen.zPosition = 199
        blackScreen.name = "blackScreen"
        cameraNode.addChild(blackScreen)
        
        //Configure win screen image
        winScreen.position = CGPoint(x: 0, y: -10)
        winScreen.zPosition = 200
        winScreen.xScale = 3
        winScreen.yScale = 3
        winScreen.name = "winScreen"
        cameraNode.addChild(winScreen)
        
        //Configure home button
        homeButton.position = CGPoint(x: 0, y: -100)
        homeButton.zPosition = 201
        homeButton.xScale = 3
        homeButton.yScale = 3
        homeButton.name = "homeButton"
        cameraNode.addChild(homeButton)
    }
    
    func gameOver() {
        //Stops the timer
        isTimerRunning = false
        removeAllActions()
        
        player.removeFromParent()
        
        //Black screen as background for game over image
        blackScreen.position = CGPoint(x: 0, y: 0)
        blackScreen.zPosition = 199
        blackScreen.name = "blackScreen"
        cameraNode.addChild(blackScreen)
    
        //Configure game over image
        gameOverImage.position = CGPoint(x: 0, y: -10)
        gameOverImage.zPosition = 200
        gameOverImage.xScale = 3
        gameOverImage.yScale = 3
        gameOverImage.name = "gameOverImage"
        cameraNode.addChild(gameOverImage)
        
        //Configure retry button
        retryButton.position = CGPoint(x: 0, y: -100)
        retryButton.zPosition = 201
        retryButton.xScale = 3
        retryButton.yScale = 3
        retryButton.name = "retryButton"
        cameraNode.addChild(retryButton)
    }
    
    func resetGame() {
        //Resets player position
        player.position = CGPoint(x: 0, y: 0)
        joystick.resetJoystick()
        
        //Resets camera position
        cameraNode.position = CGPoint(x: 0, y: 0)
        
        //Adds back player node
        cameraNode.addChild(player)
        
        //Removes black background
        blackScreen.removeFromParent()
        
        //Resets timer
        countdown = 120
        timerLabel.text = "Time: \(countdown)"
        
        //Remove game over screen elements
        gameOverImage.removeFromParent()
        retryButton.removeFromParent()
        
        //Reset game state
        isTimerRunning = false
        startTimer()
    }
    
    func hideTrace() {
        traceButton.isHidden = true
    }
    
    func showTrace() {
        traceButton.isHidden = false
    }
    
    func hideElectric() {
        electricButton.isHidden = true
    }
    
    func electricOff() {
        onElectricalBox.isHidden = true
        offElectricalBox.isHidden = false
    }
    
    func electricOn() {
        onElectricalBox.isHidden = false
        offElectricalBox.isHidden = true
    }
    
    func offLasers() {
        onLaser.isHidden = true
        offLaser.isHidden = false
        onLaser.physicsBody?.categoryBitMask = 0
        onLaser.physicsBody?.collisionBitMask = 0
        rangePainting.isHidden = true
        rangePainting.physicsBody?.categoryBitMask = 0
        rangePainting.physicsBody?.collisionBitMask = 0
    }
    
    func onLasers() {
        onLaser.isHidden = false
        offLaser.isHidden = true
        onLaser.physicsBody?.categoryBitMask = obstacle
        onLaser.physicsBody?.collisionBitMask = playerCol
        rangePainting.isHidden = false
        rangePainting.physicsBody?.categoryBitMask = obstacle
        rangePainting.physicsBody?.collisionBitMask = playerCol
    }
}
