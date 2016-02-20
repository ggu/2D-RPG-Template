//
//  SkillButton.swift
//  Borba
//
//  Created by Gabriel Uribe on 1/31/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import Foundation

import SpriteKit

protocol SkillButtonDelegate {
  func skillButtonTouched(skillName: Spells)
}

class SkillButton: SKSpriteNode {
  var active = false
  var delegate: SkillButtonDelegate?
  var spell: Spells
  
  init(spell: Spells, color: UIColor, size: CGSize) {
    self.spell = spell
    super.init(texture: nil, color: color, size: size)
    self.userInteractionEnabled = true
    let labelNode : SKLabelNode
    
    switch spell {
    case .Fireball:
      labelNode = SKLabelNode(text: "1")
    case .Frostbolt:
      labelNode = SKLabelNode(text: "2")
    case .Lightning:
      labelNode = SKLabelNode(text: "3")
    }
    labelNode.fontName = "Copperplate"
    labelNode.fontSize = 16
    labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
    labelNode.position = CGPointMake(labelNode.position.x, labelNode.position.y - 4)
    
    addChild(labelNode)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    active = true
    delegate?.skillButtonTouched(spell)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}