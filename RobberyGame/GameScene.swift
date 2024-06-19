//
//  GameScene.swift
//  RobberyGame
//
//  Created by James Cellars on 11/06/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SneakyJoystickDelegate, SKPhysicsContactDelegate {
    
    //Create game border
    var gameBorder = GameBorder()
    
    //Create joystick on scene
    let joystick = Joystick()
    
    //Create player instance
    let player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
    
    //Create protector instance (ask Michelle what's the difference between this and enemy)
    var protector = Protector(size: CGSize(width: 10, height: 50))
    
    //Check with Michelle if this is needed or not
    var coneShape = ConeShape()
    
    //Create enemy instance
    var enemy = Enemy(size: CGSize(width: 50, height: 50))
    
    //Create camera node
    let cameraNode = SKCameraNode()
    
    //Create individual lines as the border
    let topLine = SKShapeNode()
    let rightLine = SKShapeNode()
    let bottomLine = SKShapeNode()
    let leftLine = SKShapeNode()
    
    //Checking if player is currently colliding with respective borders
    var isPlayerTouchingBorder = false
    var isTouchingTop = false
    var isTouchingRight = false
    var isTouchingBottom = false
    var isTouchingLeft = false
    
    //Variables for Contact Test Bit Mask (Colliding) (Category Bit Mask)
    let playerCol: UInt32 = 0x1 << 0
    
    let topCol: UInt32 = 0x1 << 1
    let rightCol: UInt32 = 0x1 << 2
    let bottomCol: UInt32 = 0x1 << 3
    let leftCol: UInt32 = 0x1 << 4
    let protectorCol: UInt32 = 0x1 << 5
    let enemyCol: UInt32 = 0x1 << 6
    let coneCol: UInt32 = 0x1 << 7
    
    //Timer properties
    var timerLabel: SKLabelNode!
    var countdown: Int = 60
    var isTimerRunning = false
    
    override required init(size: CGSize) {
        super.init(size: size)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        
        //Border properties
        addChild(gameBorder)
        gameBorder.addChild(protector)
        gameBorder.addChild(enemy)
        player.addChild(coneShape)
        
        //Position cone shape relative to player
        coneShape.position = CGPoint(x: player.size.width / 2 + coneShape.frame.width / 2, y: 0)
        protector.position = CGPoint(x: 350, y: 0)
        enemy.position = CGPoint(x: 320, y: 0)
        protector.zPosition = enemy.zPosition + 1
        
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
        
        
        //Create physics body for player
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height))
        
        //Category and collision masks for player node
        player.physicsBody?.categoryBitMask = playerCol
        player.physicsBody?.collisionBitMask = topCol | rightCol | bottomCol | leftCol
        player.physicsBody?.contactTestBitMask = topCol | rightCol | bottomCol | leftCol
        
        //Category masks for protector, cone and enemy
        protector.physicsBody?.categoryBitMask = protectorCol
        coneShape.physicsBody?.categoryBitMask = coneCol
        enemy.physicsBody?.categoryBitMask = enemyCol
        
        //Contact test bit masks
        coneShape.physicsBody?.contactTestBitMask = playerCol | enemyCol
        enemy.physicsBody?.contactTestBitMask = enemyCol
        
        //Collision bit masks for protector, cone and enemy
        protector.physicsBody?.collisionBitMask = 0
        coneShape.physicsBody?.collisionBitMask = 0
        enemy.physicsBody?.collisionBitMask = 0
        
        //Ensure contact notifications are still sent
        coneShape.physicsBody?.contactTestBitMask = coneShape.physicsBody!.categoryBitMask
        enemy.physicsBody?.contactTestBitMask = coneShape.physicsBody!.categoryBitMask
        
        //Prevent objects falling over
        protector.physicsBody?.affectedByGravity = false
        coneShape.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.affectedByGravity = false
        
        joystick.position = CGPoint(x: -150, y: 450)
        
        //Add physics to player instance
        player.position = CGPoint(x: 0, y: 0)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        //Physics bodies for protector, coneShape and enemy
        let enemyPhysicsSize = CGSize(width: enemy.size.width, height: enemy.size.height)
        coneShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100), center: CGPoint(x: 50, y: 50))
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemyPhysicsSize, center: CGPoint(x: enemyPhysicsSize.width / 2, y: enemyPhysicsSize.height / 2))
        protector.physicsBody = SKPhysicsBody(rectangleOf: protector.size, center: CGPoint(x: protector.size.width / 2, y: protector.size.height / 2))
        
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
        
    }
    
    //Handling collision response
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        //Add response later eg. sound effects
        if contact.bodyA.categoryBitMask == 0b1 || contact.bodyB.categoryBitMask == 0b1 {
            handleCollision(contact: contact)
            
            return
        } else if collision == enemyCol {
            //Player and enemy collision
            backgroundColor = SKColor.yellow
            print("Game over")
            
            //Stop enemy's movement
            enemy.removeAllActions()
            coneShape.removeAllActions()
            player.removeAllActions()
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
