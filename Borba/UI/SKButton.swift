//
//  SKButton.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

protocol SKButtonDelegate
{
  func buttonTapped(type: ButtonType)
  // button tapped function
  // !!! to-do: add property that holds the button action on tap?
}

class SKButton : SKSpriteNode
{
  var button: SKButtonContents?
  var buttonType: ButtonType?
  var delegate: SKButtonDelegate?
  convenience init(color: UIColor, text: String, type: ButtonType)
  {
    let buttonNode = SKButtonContents(color: color, text: text)
		let buttonWidth = buttonNode.frame.size.width + 50 // 50 is the invisible padding for tappable area
		let buttonHeight = buttonNode.frame.size.height + 50
    self.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(buttonWidth, buttonHeight))
    setup(buttonNode, type: type)
  }
  
  func setup(buttonNode : SKButtonContents, type: ButtonType)
  {
    buttonType = type
    userInteractionEnabled = true
    // zPosition = zPositions.joystick
    button = buttonNode
    addChild(button!)
  }
  
  func setMargins(horizontal: Int, vertical: Int)
  {
    
  }
  
  func changeText(text: String)
  {
    
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
  {
    if let theDelegate = delegate {
      if let type = buttonType {
        theDelegate.buttonTapped(type)
      }
    }
    
  }
}