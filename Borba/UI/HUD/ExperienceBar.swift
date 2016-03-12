//
//  ExperienceBar.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/2/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class ExperienceBar: SKSpriteNode {
  private var experienceMeter: SKSpriteNode = SKSpriteNode(texture: nil, color: UIColor.whiteColor(), size: CGSize(width: 192, height: 4))
  
  init(width: CGFloat, height: CGFloat) {
    super.init(texture: nil, color: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), size: CGSize(width: 200, height: 6))
    setup(width, height: height)
  }
  
  private func setup(width: CGFloat, height: CGFloat) {
    let yPos = height - size.height/2 - 16
    position = CGPoint(x: 160, y: yPos)
    zPosition = 10
    experienceMeter.xScale = 0
    
    experienceMeter.anchorPoint = CGPoint(x: 0, y: 0)
    experienceMeter.position = CGPoint(x: -96, y: -1)
    addChild(experienceMeter)
  }
  
  func setMeterScale(scale: CGFloat) {
    if experienceMeter.xScale > scale {
      experienceMeter.xScale = 0
    }
    
    let makeVisible = SKAction.sequence([SKAction.fadeAlphaTo(1.0, duration: 0.6), SKAction.fadeAlphaTo(0.5, duration: 0.6)])
    let animateX = SKAction.scaleXTo(scale, duration: 0.6)
    experienceMeter.runAction(SKAction.group([makeVisible, animateX]))
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
