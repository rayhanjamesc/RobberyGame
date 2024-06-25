//
//  Joystick.swift
//  RobberyGame
//
//  Created by James Cellars on 11/06/24.
//

import Foundation
import SpriteKit

//Protocol for camera movement
protocol SneakyJoystickDelegate {
    func joystickMoved(to direction: CGPoint)
}

class Joystick: SKNode {
    var player: Fox?
    
    var delegate: SneakyJoystickDelegate?
//    var isMoving:Bool = false
    
    //Gray joystick on the bottom
    var joystick = SKShapeNode()
    
    //Movable black stick attached to the bottom
    var stick = SKShapeNode()
    
    //Set max movable range of the var stick
    let maxRange: CGFloat = 20
    
    //Stores current value of stick's position within the joystick
    var xValue: CGFloat = 0
    var yValue: CGFloat = 0
    
    //Add speed factor to change joystick movement speeds
    var speedFactor: CGFloat = 0.25
    
    //Variable for joystick speed
    var joystickAction: ((_ x: CGFloat, _ y: CGFloat) -> ())?
    
    var cumulativeMovement: CGFloat = 0 // Add this property

    
    //Properties for the whole joystick
    override init() {
        
        //Gray background joystick
        let joystickRect = CGRect(x: 0, y: 0, width: 150, height: 150)
        let joystickPath = UIBezierPath(ovalIn: joystickRect)
        
        joystick = SKShapeNode(path: joystickPath.cgPath, centered: true)
        joystick.fillColor = UIColor.gray
        joystick.strokeColor = UIColor.clear
        joystick.alpha = 0.4
        
        //Black movable stick
        let stickRect = CGRect(x: 0, y: 0, width: 60, height: 60)
        let stickPath = UIBezierPath(ovalIn: stickRect)
        
        stick = SKShapeNode(path: stickPath.cgPath, centered: true)
        stick.fillColor = UIColor.gray
        stick.strokeColor = UIColor.white
        stick.lineWidth = 4
        
        super.init()
        
        addChild(joystick)
        addChild(stick)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Moving the joystick
    func moveJoystick(touch: UITouch) {
    
        let p = touch.location(in: self)
        let x = p.x.clamped(-maxRange, maxRange)
        let y = p.y.clamped(-maxRange, maxRange)

        stick.position = CGPoint(x: x, y: y)
        xValue = x / maxRange * speedFactor
        yValue = y / maxRange * speedFactor
        
        // Calculate the distance moved
        let distanceMoved = sqrt(x * x + y * y)
        cumulativeMovement += distanceMoved

        // Check if the cumulative movement exceeds the threshold
        if cumulativeMovement >= 500 {
            player?.walkingState()
            cumulativeMovement = 0 // Reset the cumulative movement
        }
        
                if let delegate = delegate {
            delegate.joystickMoved(to: CGPoint(x: xValue, y: yValue))
        }
    }
    
    //Stops player movement when joystick is released
    func resetJoystick() {
        xValue = 0
        yValue = 0
        stick.position = .zero
        
        player?.idleState()

        if let delegate = delegate {
            delegate.joystickMoved(to: CGPoint(x: xValue, y: yValue))
        }
  
        
        if let joystickAction = joystickAction {
            joystickAction(xValue, yValue)
        }
        
    }
}


extension CGFloat {
    
    func clamped(_ v1: CGFloat,_ v2: CGFloat) -> CGFloat {
        let min = v1 < v2 ? v1 : v2
        let max = v1 > v2 ? v1 : v2
        return self < min ? min : (self > max ? max : self)
    }
}
