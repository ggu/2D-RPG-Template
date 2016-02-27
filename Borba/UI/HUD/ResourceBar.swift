//
//  HealthBar.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/2/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class ResourceBar: SKSpriteNode {
  var resourceMeter: SKSpriteNode = SKSpriteNode(texture: nil, color: UIColor.greenColor(), size: CGSize(width: 192, height: 14))
  init(width: CGFloat, height: CGFloat, xPosition: CGFloat, color: UIColor) {
    super.init(texture: nil, color: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), size: CGSize(width: 200, height: 16))
    setup(width, height: height, xPosition: xPosition, color: color)
  }
  
  private func setup(width: CGFloat, height: CGFloat, xPosition: CGFloat, color: UIColor) {
    let yPos = height - size.height/2
    position = CGPoint(x: xPosition, y: yPos)
    zPosition = 10
    
    resourceMeter.anchorPoint = CGPoint(x: 0, y: 0)
    resourceMeter.color = color
    resourceMeter.position = CGPoint(x: -96, y: -6)
    addChild(resourceMeter)
  }
  
  func setMeterScaleAnimated(scale: CGFloat) {
    if resourceMeter.xScale > scale {
      resourceMeter.xScale = 0
    }
    
    let animateX = SKAction.scaleXTo(scale, duration: 0.05)
    resourceMeter.runAction(animateX)
  }
  
  func setMeterScale(scale: Double) {
    resourceMeter.xScale = CGFloat(scale)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
