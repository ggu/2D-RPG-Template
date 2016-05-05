//
//  SKButton.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

protocol SKButtonDelegate {
  func buttonTapped(type: SKButton.Tag)
}

class SKButton : SKSpriteNode {
  enum Tag {// need to make MainMenu a type of ButtonType
      case mainMenuPlay
      case mainMenuSettings
  }
  
  static let padding: CGFloat = 50
  
  private var button: SKButtonContents
  var tag: Tag
  var delegate: SKButtonDelegate?
  
  init(color: UIColor, text: String, tag: SKButton.Tag) {
    self.tag = tag

    self.button = SKButtonContents(color: color, text: text)
		let buttonWidth = self.button.frame.size.width + SKButton.padding
		let buttonHeight = self.button.frame.size.height + SKButton.padding
    super.init(texture: nil, color: UIColor.clearColor(), size: CGSize(width: buttonWidth, height: buttonHeight))
    
    setup()
  }
  
  private func setup() {
    userInteractionEnabled = true
    addChild(button)
  }
  
  private func setMargins(horizontal: Int, vertical: Int) {
    
  }
  
  func changeText(text: String) {
    
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    delegate?.buttonTapped(tag)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
