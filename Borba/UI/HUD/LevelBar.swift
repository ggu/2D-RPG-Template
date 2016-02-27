//
//  LevelBar.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/2/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class LevelBar: SKSpriteNode {
  var levelLabel = SKLabelNode(text: "1")
  init(width: CGFloat, height: CGFloat) {
    super.init(texture: nil, color: UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1), size: CGSize(width: 40, height: 16))
    setup(width, height: height)
  }
  
  private func setup(width: CGFloat, height: CGFloat) {
    let yPos = height - size.height/2
    position = CGPoint(x: 280, y: yPos)
    zPosition = 10
    
    levelLabel.fontSize = 12
    levelLabel.fontName = "AmericanTypewriter"
    levelLabel.fontColor = UIColor.blackColor()
    levelLabel.position = CGPoint(x: levelLabel.position.x, y: -4)
    addChild(levelLabel)
  }
  
  func setLevel(level: String) {
    levelLabel.text = level
    let goldenAction = SKAction.colorizeWithColor(UIColor.yellowColor(), colorBlendFactor: 1, duration: 0.3)
    let returnAction = SKAction.colorizeWithColor(UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1), colorBlendFactor: 1, duration: 0.3)
    runAction(SKAction.sequence([goldenAction, returnAction]))
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
