//
//  HealthBar.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/2/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class ResourceBar: SKSpriteNode
{
  var resourceMeter: SKSpriteNode = SKSpriteNode(texture: nil, color: UIColor.greenColor(), size: CGSizeMake(192, 14))
  init(width: CGFloat, height: CGFloat, xPosition: CGFloat, color: UIColor) {
    super.init(texture: nil, color: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), size: CGSizeMake(200, 16))
    setup(width, height: height, xPosition: xPosition, color: color)
  }
  
  func setup(width: CGFloat, height: CGFloat, xPosition: CGFloat, color: UIColor)
  {
    let yPos = height - size.height/2
    position = CGPointMake(xPosition, yPos)
    zPosition = 10
    
    resourceMeter.anchorPoint = CGPointMake(0, 0)
    resourceMeter.color = color
    resourceMeter.position = CGPointMake(-96, -6)
    addChild(resourceMeter)
  }
  
  func setMeterScale(scale: Double)
  {
    // should add an animation to this
    resourceMeter.xScale = CGFloat(scale)
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
  }
}
