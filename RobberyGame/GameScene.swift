//
//  GameScene.swift
//  RobberyGame
//
//  Created by James Cellars on 11/06/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //Create joystick on scene
    let joystick = Joystick()
    
    //Create player instance
    let player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
    
    override func didMove(to view: SKView) {
        
        //Create visible border
        let borderNode = SKShapeNode(rect: CGRect(x: -250, y: -250, width: 500, height: 500))
        borderNode.strokeColor = SKColor.white
        borderNode.lineWidth = 2.0
        self.addChild(borderNode)
        
        joystick.position = CGPoint(x: -150, y: 450)
        addChild(joystick)
        addChild(player)
        
        //Add physics to player instance
        player.position = CGPoint(x: -150, y: -150)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        let xMovement = joystick.xValue
        let yMovement = joystick.yValue
        
        let newX = player.position.x + xMovement * 50
        let newY = player.position.y + yMovement * 50
        
        //Checks if new position is within the border
        if newX >= -250 && newX <= 250 && newY >= -250 && newY <= 250 {
            player.position.x = newX
            player.position.y = newY
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        joystick.moveJoystick(touch: touches.first!)
        
        joystick.joystickAction = { [weak self] (x: CGFloat, y: CGFloat) in
            self?.player.physicsBody?.applyForce(CGVector(dx: x * 70, dy: y * 70))
            self?.player.physicsBody?.linearDamping = 0
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        joystick.xValue = 0
        joystick.yValue = 0
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.player.physicsBody?.linearDamping = 100
    }
}
