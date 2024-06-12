//
//  Joystick.swift
//  RobberyGame
//
//  Created by James Cellars on 11/06/24.
//

import Foundation
import SpriteKit

class Joystick: SKNode {
    
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
    var speedFactor: CGFloat = 0.05
    
    //Variable for joystick speed
    var joystickAction: ((_ x: CGFloat, _ y: CGFloat) -> ())?
    
    //Properties for the whole joystick
    override init() {
        
        //Gray background joystick
        let joystickRect = CGRect(x: 0, y: 0, width: 200, height: 200)
        let joystickPath = UIBezierPath(ovalIn: joystickRect)
        
        joystick = SKShapeNode(path: joystickPath.cgPath, centered: true)
        joystick.fillColor = UIColor.gray
        joystick.strokeColor = UIColor.clear
        
        //Black movable stick
        let stickRect = CGRect(x: 0, y: 0, width: 80, height: 80)
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
    }
    
}


extension CGFloat {
    
    func clamped(_ v1: CGFloat,_ v2: CGFloat) -> CGFloat {
        let min = v1 < v2 ? v1 : v2
        let max = v1 > v2 ? v1 : v2
        return self < min ? min : (self > max ? max : self)
    }
}
