//
//  SKButton.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class SKButtonContents : SKSpriteNode
{
  var label : SKLabelNode?
  init(color: UIColor, text: String)
  {
    let labelNode : SKLabelNode = SKLabelNode(text: text);
    labelNode.fontName = "Copperplate"
    let labelFrame = labelNode.frame
    let buttonWidth = labelFrame.width + Button.leftMargin + Button.rightMargin
    let buttonHeight = labelFrame.height + Button.topMargin + Button.bottomMargin
    let size = CGSizeMake(buttonWidth, buttonHeight)
    super.init(texture: nil, color: color, size: size)
    setup(labelNode)
  }
  
  func setup(labelNode: SKLabelNode)
  {
    label = labelNode
    label!.position = CGPointMake(0, -Button.topMargin)
    addChild(label!)
    
  }
  
  func setMargins(horizontal: Int, vertical: Int)
  {
    
  }
  
  func changeText(text: String)
  {
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
  }
}
