//
//  SKJoystick.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/1/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class SKJoystick: SKSpriteNode {
  private enum MaxValue {
    static let AbsX: CGFloat = 70
    static let AbsY: CGFloat = 70
  }
  
  private var active = false
  private var backdrop: SKShapeNode
  private var thumbStick = SKShapeNode(circleOfRadius: 20)
  var angle: CGFloat = 0
  var thumbX: CGFloat = 0
  var thumbY: CGFloat = 0
  
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    backdrop = SKShapeNode(circleOfRadius: size.width / 2)
    super.init(texture: nil, color: UIColor.clearColor(), size: size)
    setup()
  }
  
  private func setup() {
    setupBackdrop()
    setupThumbstick()
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if (!active) {
      active = true;
    }
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    for touch: AnyObject in touches {
      let location = touch.locationInNode(self)
      
      var newX: CGFloat = thumbStick.position.x
      var newY: CGFloat = thumbStick.position.y
      
      if fabs(location.x) < SKJoystick.MaxValue.AbsX {
        newX = location.x;
      }
      if fabs(location.y) < SKJoystick.MaxValue.AbsY {
        newY = location.y;
      }
      thumbStick.position = CGPoint(x: newX, y: newY)
      thumbX = newX
      thumbY = newY
      angle = -atan2(newX, newY)
    }
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.resetThumbstick()
    self.resetProperties()
  }
  
  private func resetThumbstick() {
    thumbStick.runAction(SKAction.moveTo(CGPointZero, duration: 0.3))
  }
  
  private func resetProperties() {
    active = false
    thumbX = 0
    thumbY = 0
  }
  
  private func setupBackdrop() {
    backdrop.fillColor = UIColor.grayColor()
    backdrop.strokeColor = UIColor.whiteColor()
    addChild(backdrop)
  }
  
  private func setupThumbstick() {
    thumbStick.strokeColor = UIColor.grayColor()
    thumbStick.fillColor = UIColor.grayColor()
    userInteractionEnabled = true
    alpha = 0.6
    zPosition = zPositions.Joystick
    thumbStick.zPosition = zPositions.Thumbstick
    self.addChild(thumbStick)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
