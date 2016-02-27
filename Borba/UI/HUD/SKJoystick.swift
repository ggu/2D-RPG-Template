//
//  SKJoystick.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/1/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class SKJoystick: SKSpriteNode
{
  var active = false
  var angle: CGFloat = 0
  var thumbX: CGFloat = 0
  var thumbY: CGFloat = 0
  var thumbStick = SKShapeNode(circleOfRadius: 20)
  var backdrop: SKShapeNode
  
  override init(texture: SKTexture?, color: UIColor, size: CGSize)
  {
    backdrop = SKShapeNode(circleOfRadius: size.width / 2)
    backdrop.fillColor = UIColor.grayColor()
    backdrop.strokeColor = UIColor.whiteColor()
    super.init(texture: nil, color: UIColor.clearColor(), size: size)
    addChild(backdrop)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func setup()
  {
    thumbStick.strokeColor = UIColor.grayColor()
    thumbStick.fillColor = UIColor.grayColor()
    userInteractionEnabled = true
    alpha = 0.6
    zPosition = zPositions.joystick
    thumbStick.zPosition = zPositions.thumbstick
    self.addChild(thumbStick)
    
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
  {
    if (!active)
    {
      active = true;
    }
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
  {
    for touch: AnyObject in touches
    {
      let location = touch.locationInNode(self)
      
      var newX: CGFloat = thumbStick.position.x
      var newY: CGFloat = thumbStick.position.y
      
      if fabs(location.x) < thumbstickValues.maxAbsX {
        newX = location.x;
      }
      if fabs(location.y) < thumbstickValues.maxAbsY {
        newY = location.y;
      }
      thumbStick.position = CGPointMake(newX, newY)
      thumbX = newX
      thumbY = newY
      angle = -atan2(newX, newY)
    }
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
  {
    self.resetThumbstick()
    self.resetProperties()
  }
  
  func resetThumbstick()
  {
    thumbStick.runAction(SKAction.moveTo(CGPointZero, duration: 0.3))
  }
  
  func resetProperties()
  {
    active = false
    thumbX = 0
    thumbY = 0
  }
  
}