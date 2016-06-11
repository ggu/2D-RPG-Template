//
//  SkillButton.swift
//  Borba
//
//  Created by Gabriel Uribe on 1/31/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

protocol SkillButtonDelegate {
  func skillButtonTouched(skillName: SpellString)
}

class SkillButton: SKSpriteNode {
  var active = false
  var delegate: SkillButtonDelegate?
  var spell: SpellString = Spell.String.fireball
  
  init(spell: Spell.Name, color: UIColor, size: CGSize) {
    super.init(texture: nil, color: color, size: size)
    setup(spell)
  }
  
  private func setup(spellName: Spell.Name) {
    self.userInteractionEnabled = true
    let labelNode : SKLabelNode
    
    switch spellName {
    case .fireball:
      labelNode = SKLabelNode(text: "1")
      spell = Spell.String.fireball
    case .arcaneBolt:
      labelNode = SKLabelNode(text: "2")
      spell = Spell.String.arcaneBolt
    case .lightning:
      labelNode = SKLabelNode(text: "3")
      spell = Spell.String.lightningBolt
    }
    labelNode.fontName = "Copperplate"
    labelNode.fontSize = 16
    labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
    labelNode.position = CGPoint(x: labelNode.position.x, y: labelNode.position.y - 4)
    
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
