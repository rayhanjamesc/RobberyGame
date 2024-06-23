//
//  GameScene.swift
//  RobberyGame
//
//  Created by James Cellars on 11/06/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SneakyJoystickDelegate, SKPhysicsContactDelegate {
    
    //Create joystick on scene
    let joystick = Joystick()
    
    //Create player instance
    let player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
    
    //Create camera node
    let cameraNode = SKCameraNode()
    
    //Create individual lines as the border
    let topLine = SKShapeNode()
    let rightLine = SKShapeNode()
    let bottomLine = SKShapeNode()
    let leftLine = SKShapeNode()
    
    //Game walls
    let room1_1 = SKSpriteNode(imageNamed: "room1_1.png")
    
    //Checking if player is currently colliding with respective borders
    var isPlayerTouchingBorder = false
    var isTouchingTop = false
    var isTouchingRight = false
    var isTouchingBottom = false
    var isTouchingLeft = false
    
    //Variables for Contact Test Bit Mask (Colliding)
    let playerCol: UInt32 = 0x1 << 0
    
    let topCol: UInt32 = 0x1 << 1
    let rightCol: UInt32 = 0x1 << 2
    let bottomCol: UInt32 = 0x1 << 3
    let leftCol: UInt32 = 0x1 << 4
    
    //Timer properties
    var timerLabel: SKLabelNode!
    var countdown: Int = 60
    var isTimerRunning = false
    
    override func didMove(to view: SKView) {
        view.showsPhysics = true
        view.showsNodeCount = true
        view.showsFPS = true
        
        //Set screen size for horizontal layout
        self.size = CGSize(width: 1334, height: 750)
        self.scaleMode = .aspectFit
        
        //Line properties
        let topPath = UIBezierPath()
        topPath.move(to: CGPoint(x: -100, y: 50))
        topPath.addLine(to: CGPoint(x: 150, y: 50))
        topLine.path = topPath.cgPath
        topLine.strokeColor = SKColor.red
        topLine.lineWidth = 2.0
        addChild(topLine)
        
        let rightPath = UIBezierPath()
        rightPath.move(to: CGPoint(x: 150, y: 50))
        rightPath.addLine(to: CGPoint(x: 150, y: -150))
        rightLine.path = rightPath.cgPath
        rightLine.strokeColor = SKColor.red
        rightLine.lineWidth = 2.0
        addChild(rightLine)
        
        let bottomPath = UIBezierPath()
        bottomPath.move(to: CGPoint(x: 150, y: -150))
        bottomPath.addLine(to: CGPoint(x: -100, y: -150))
        bottomLine.path = bottomPath.cgPath
        bottomLine.strokeColor = SKColor.red
        bottomLine.lineWidth = 2.0
        addChild(bottomLine)
        
        let leftPath = UIBezierPath()
        leftPath.move(to: CGPoint(x: -100, y: -150))
        leftPath.addLine(to: CGPoint(x: -100, y: 50))
        leftLine.path = leftPath.cgPath
        leftLine.strokeColor = SKColor.red
        leftLine.lineWidth = 2.0
        addChild(leftLine)
        
        physicsWorld.contactDelegate = self
        
        //Top line physics body and category
        topLine.physicsBody = SKPhysicsBody(edgeLoopFrom: topLine.frame)
        topLine.physicsBody?.categoryBitMask = topCol
        topLine.physicsBody?.collisionBitMask = playerCol
        
        //Right line physics body and category
        rightLine.physicsBody = SKPhysicsBody(edgeLoopFrom: rightLine.frame)
        rightLine.physicsBody?.categoryBitMask = rightCol
        rightLine.physicsBody?.collisionBitMask = playerCol
        
        //Bottom line physics body and category
        bottomLine.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomLine.frame)
        bottomLine.physicsBody?.categoryBitMask = bottomCol
        bottomLine.physicsBody?.collisionBitMask = playerCol
        
        //Left line physics body and category
        leftLine.physicsBody = SKPhysicsBody(edgeLoopFrom: leftLine.frame)
        leftLine.physicsBody?.categoryBitMask = leftCol
        leftLine.physicsBody?.collisionBitMask = playerCol
        
        //Physics body for left walls
        
            room1_1.physicsBody = SKPhysicsBody(edgeLoopFrom: room1_1.frame)
            room1_1.physicsBody?.categoryBitMask = leftCol
            room1_1.physicsBody?.collisionBitMask = playerCol
        
        //Create physics body for player
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height))
        
        //Category and collision masks for player node
        player.physicsBody?.categoryBitMask = playerCol
        player.physicsBody?.collisionBitMask = topCol | rightCol | bottomCol | leftCol
        player.physicsBody?.contactTestBitMask = topCol | rightCol | bottomCol | leftCol
        
        joystick.position = CGPoint(x: -500, y: -225)
        
        //Add physics to player instance
        player.position = CGPoint(x: 0, y: 0)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
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
        
        //Add walls to the scene
        setupWalls()
    }
    
    //Add walls to the map
    func setupWalls() {
        // Room 1_1
        room1_1.position = CGPoint(x: -35, y: 30)
        room1_1.physicsBody?.isDynamic = false
        addChild(room1_1)
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
                print("timer started")
                startTimer()
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
        } else {
            cameraNode.position.x += cameraMovement.x
            cameraNode.position.y += cameraMovement.y
        }
    }
    
    func handleCollision(contact: SKPhysicsContact) {
        var otherBody: SKPhysicsBody
        
        if(contact.bodyA.categoryBitMask == topCol) {
            otherBody = contact.bodyB
            isPlayerTouchingBorder = true
            isTouchingTop = true
        } else if(contact.bodyA.categoryBitMask == rightCol) {
            otherBody = contact.bodyB
            isPlayerTouchingBorder = true
            isTouchingRight = true
        } else if(contact.bodyA.categoryBitMask == bottomCol) {
            otherBody = contact.bodyB
            isPlayerTouchingBorder = true
            isTouchingBottom = true
        } else if(contact.bodyA.categoryBitMask == leftCol) {
            otherBody = contact.bodyB
            isPlayerTouchingBorder = true
            isTouchingLeft = true
        } else {
            otherBody = contact.bodyA
            isPlayerTouchingBorder = true
        }
        
        switch otherBody.categoryBitMask {
        case 0b1:
            player.color = SKColor.red
        case 0b1000:
            player.color = SKColor.red
            
        default:
            break
        }
    }
    
    func startTimer() {
        if !isTimerRunning {
            print("function is running")
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
            isTimerRunning = false
            removeAction(forKey: "timer")
            
            //Handle timer end (add game over later)
        }
    }
}
