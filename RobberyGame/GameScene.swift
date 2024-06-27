//
//  GameScene.swift
//  RobberyGame
//
//  Created by James Cellars on 11/06/24.
//

import SpriteKit
import GameplayKit
import GameKit

class GameScene: SKScene, SneakyJoystickDelegate, SKPhysicsContactDelegate {
    
    var match: GKMatch?
    var playerA = Fox()
    var playerB = Cat()
    
    //Reference to GameViewController
    weak var gameViewController: GameViewController?
    
    //Create joystick on scene
    let joystick = Joystick()
    
    //Create player instance
    var player = SKSpriteNode()
    
    //Create camera node
    let cameraNode = SKCameraNode()
    
    
    //Setup multiplayer
    func startMultiplayerGame(with match: GKMatch) {
            self.match = match
            
            // Set up player 1 and player 2
            let player = playerA
    }
        
    func handleReceivedData(_ data: Data) {
        // Decode and process the received data
        // For example, update player positions based on received data
    }
        
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
            
        // Send player positions to other player
        if let match = match {
            let playerData = createDataToSend()
            try? match.sendData(toAllPlayers: playerData, with: .reliable)
        }
    }
        
    func createDataToSend() -> Data {
        // Create data to send to the other player
        // For example, player positions
        return Data()
    }
    
    //Win mechanic conditional
    
    //Game walls
    let room1_1 = SKSpriteNode(imageNamed: "room1_1.png")
    let room1_2 = SKSpriteNode(imageNamed: "room1_2.png")
    let room1_3 = SKSpriteNode(imageNamed: "room1_3.png")
    let hallway1_1 = SKSpriteNode(imageNamed: "hallway1_1.png")
    let hallway1_2 = SKSpriteNode(imageNamed: "hallway1_2.png")
    let room1_4 = SKSpriteNode(imageNamed: "room1_4.png")
    let room1_5 = SKSpriteNode(imageNamed: "room1_5.png")
    
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
        
            room2_1.physicsBody = SKPhysicsBody(texture: room2_1.texture!, size: room2_1.size)
            room2_1.physicsBody?.categoryBitMask = leftCol
            room2_1.physicsBody?.collisionBitMask = playerCol
            
            room2_2.physicsBody = SKPhysicsBody(texture: room2_2.texture!, size: room2_2.size)
            room2_2.physicsBody?.categoryBitMask = topCol
            room2_2.physicsBody?.collisionBitMask = playerCol
        
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
            
            room2_8.physicsBody = SKPhysicsBody(texture: room2_8.texture!, size: room2_8.size)
            room2_8.physicsBody?.categoryBitMask = topCol
            room2_8.physicsBody?.collisionBitMask = playerCol
        
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
        
        //Create physics body for player
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height))
        
        //Category and collision masks for player node
        player.physicsBody?.categoryBitMask = playerCol
        player.physicsBody?.collisionBitMask = topCol | rightCol | bottomCol | leftCol | diagonalTopLeftCol | diagonalTopRightCol | diagonalBottomLeftCol | diagonalBottomRightCol
        player.physicsBody?.contactTestBitMask = topCol | rightCol | bottomCol | leftCol | diagonalTopLeftCol | diagonalTopRightCol | diagonalBottomLeftCol | diagonalBottomRightCol
        
        joystick.position = CGPoint(x: -500, y: -225)
        joystick.zPosition = 2
        
        //Add physics to player instance
        player.position = CGPoint(x: 0, y: 0)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        //Camera node properties
        cameraNode.position = CGPoint(x: 0, y: 0)
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
        let traceButton = UIButton(type: .custom)
        traceButton.setTitle("Start tracing", for: .normal)
        traceButton.setTitleColor(.blue, for: .normal)
        traceButton.addTarget(self, action: #selector(traceButtonPressed), for: .touchUpInside)
        self.view?.addSubview(traceButton)
        traceButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        //Add walls to the scene
        setupWalls()
    }
    
    @objc func traceButtonPressed() {
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
    }
    
    //Handling collision response
    func didBegin(_ contact: SKPhysicsContact) {
        //Add response later eg. sound effects
        if contact.bodyA.categoryBitMask == 0b1 || contact.bodyB.categoryBitMask == 0b1 {
            handleCollision(contact: contact)
            
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "playButton" {
                startTimer()
            } else if touchedNode.name == "retryButton" {
                resetGame()
            } else {
                joystick.moveJoystick(touch: touch)
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
        } else {
            cameraNode.position.x += cameraMovement.x
            cameraNode.position.y += cameraMovement.y
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
        
        //Creates and displays game over screen
        let gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel.fontSize = 60
        gameOverLabel.fontColor = SKColor.red
        gameOverLabel.position = CGPoint(x: 0, y: 0)
        gameOverLabel.zPosition = 200
        gameOverLabel.text = "Game Over"
        gameOverLabel.name = "gameOver"
        cameraNode.addChild(gameOverLabel)
        
        //Retry button
        let retryButton = SKLabelNode(fontNamed: "Chalkduster")
        retryButton.fontSize = 40
        retryButton.fontColor = SKColor.green
        retryButton.position = CGPoint(x: 0, y: -50)
        retryButton.zPosition = 201
        retryButton.text = "Retry"
        retryButton.name = "retryButton"
        cameraNode.addChild(retryButton)
    }
    
    func resetGame() {
        //Resets player position
        player.position = CGPoint(x: 0, y: 0)
        joystick.resetJoystick()
        
        //Resets camera position
        cameraNode.position = CGPoint(x: 0, y: 0)
        
        //Resets timer
        countdown = 3
        timerLabel.text = "Time: \(countdown)"
        
        //Remove game over screen elements
        cameraNode.childNode(withName: "gameOver")?.removeFromParent()
        cameraNode.childNode(withName: "retryButton")?.removeFromParent()
        
        //Reset game state
        isTimerRunning = false
        startTimer()
        
        print("game reset")
    }
}



