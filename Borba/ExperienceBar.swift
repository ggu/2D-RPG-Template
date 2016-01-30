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
    super.init(texture: nil, color: UIColor.blackColor(), size: CGSizeMake(200, 6))
    setup(width, height: height)
  }
  
  func setup(width: CGFloat, height: CGFloat)
  {
    let yPos = height - size.height/2 - 16
    position = CGPointMake(160, yPos)
    zPosition = 10
    
    experienceMeter.anchorPoint = CGPointMake(0, 0)
    experienceMeter.position = CGPointMake(-96, -1)
    addChild(experienceMeter)
  }
  
  func setMeterScale()
  {
    // should add an animation to this
    experienceMeter.xScale = 1.0
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
  }
}
