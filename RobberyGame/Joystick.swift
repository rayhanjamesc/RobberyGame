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
    
    var delegate: SneakyJoystickDelegate?
    
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
    
    //Properties for the whole joystick
    override init() {
        
        //Gray background joystick
        let joystickRect = CGRect(x: 0, y: 0, width: 150, height: 150)
        let joystickPath = UIBezierPath(ovalIn: joystickRect)
        
        joystick = SKShapeNode(path: joystickPath.cgPath, centered: true)
        joystick.fillColor = UIColor.gray
        joystick.strokeColor = UIColor.clear
        joystick.zPosition = 1000
        
        //Black movable stick
        let stickRect = CGRect(x: 0, y: 0, width: 60, height: 60)
        let stickPath = UIBezierPath(ovalIn: stickRect)
        
        stick = SKShapeNode(path: stickPath.cgPath, centered: true)
        stick.fillColor = UIColor.gray
        stick.strokeColor = UIColor.white
        stick.lineWidth = 4
        stick.zPosition = 1001
        
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
        
        if let delegate = delegate {
            delegate.joystickMoved(to: CGPoint(x: xValue, y: yValue))
        }
    }
    
    //Stops player movement when joystick is released
    func resetJoystick() {
        xValue = 0
        yValue = 0
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
