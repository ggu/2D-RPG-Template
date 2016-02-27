//
//  ExperienceBar.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/2/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class ExperienceBar: SKSpriteNode
{
  var experienceMeter: SKSpriteNode = SKSpriteNode(texture: nil, color: UIColor.whiteColor(), size: CGSizeMake(192, 4))
  init(width: CGFloat, height: CGFloat) {
    super.init(texture: nil, color: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), size: CGSizeMake(200, 6))
    setup(width, height: height)
  }
  
  func setup(width: CGFloat, height: CGFloat)
  {
    let yPos = height - size.height/2 - 16
    position = CGPointMake(160, yPos)
    zPosition = 10
    experienceMeter.xScale = 0
    
    experienceMeter.anchorPoint = CGPointMake(0, 0)
    experienceMeter.position = CGPointMake(-96, -1)
    addChild(experienceMeter)
  }
  
  func setMeterScale(scale: CGFloat) {
    if experienceMeter.xScale > scale {
      experienceMeter.xScale = 0
    }
    
    let makeVisible = SKAction.sequence([SKAction.fadeAlphaTo(1.0, duration: 0.6), SKAction.fadeAlphaTo(0.5, duration: 0.6)])
    let animateX = SKAction.scaleXTo(scale, duration: 0.6)
    experienceMeter.runAction(SKAction.group([makeVisible, animateX]))
    //experienceMeter.xScale = CGFloat(scale)
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
  }
}
