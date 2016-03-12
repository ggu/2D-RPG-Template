//
//  SKButton.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class SKButtonContents : SKSpriteNode {
  private enum Margin {
    static let Left: CGFloat = 20
    static let Right: CGFloat = 20
    static let Top: CGFloat = 10
    static let Bottom: CGFloat = 10
  }
  
  private var label: SKLabelNode
  
  init(color: UIColor, text: String) {
    self.label = SKLabelNode(text: text);
    self.label.fontName = "Copperplate"
    let buttonWidth = self.label.frame.width + Margin.Left + Margin.Right
    let buttonHeight = self.label.frame.height + Margin.Top + Margin.Bottom
    let size = CGSize(width: buttonWidth, height: buttonHeight)
    super.init(texture: nil, color: color, size: size)
    setup()
  }
  
  private func setup() {
    label.position = CGPoint(x: 0, y: -Margin.Top)
    addChild(label)
  }
  
  func setMargins(horizontal: Int, vertical: Int) {}
  
  func changeText(text: String) {}
  
  required init?(coder aDecoder: NSCoder) {
    self.label = SKLabelNode(text: "")
    super.init(coder: aDecoder)
  }
}
