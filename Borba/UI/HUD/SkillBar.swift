//
//  SkillBar.swift
//  Borba
//
//  Created by Gabriel Uribe on 1/31/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

protocol SkillBarDelegate {
  func skillButtonTouched(skillName: SpellString)
}

class SkillBar: SKSpriteNode, SkillButtonDelegate {
  private let boxHeight: CGFloat
  private let boxMargin: CGFloat
  private var arcaneBolt: SkillButton
  private var currentSkill = Spell.String.Fireball
  private var fireball: SkillButton
  private var lightningbolt: SkillButton
  private var skills: [SkillButton]
  var delegate: SkillBarDelegate?
  
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    boxHeight = size.height / 3 * 0.8
    boxMargin = size.height - (size.height / 3 * 0.8)*3
    
    fireball = SkillButton(spell: Spell.Name.Fireball, color: UIColor.redColor(), size: CGSize(width: size.width * 0.9, height: boxHeight))
    arcaneBolt = SkillButton(spell: Spell.Name.ArcaneBolt, color: UIColor.redColor(), size: CGSize(width: size.width * 0.9, height: boxHeight))
    lightningbolt = SkillButton(spell: Spell.Name.Lightning, color: UIColor.redColor(), size: CGSize(width: size.width * 0.9, height: boxHeight))
    skills = [fireball, arcaneBolt, lightningbolt]
    
    super.init(texture: texture, color: color, size: size)
    
    setup()
  }
  
  func skillButtonTouched(skillName: SpellString) {
    currentSkill = skillName
    
    setActiveSkill(currentSkill)
    
    delegate?.skillButtonTouched(skillName)
  }
  
  private func setup() {
    alpha = 0.6
    fireBallBox()
    arcaneBoltBox()
    lightningBoltBox()
    makeSpellActive(fireball)
  }
  
  private func fireBallBox() {
    fireball.delegate = self
    fireball.position = CGPoint(x: size.width / 2 - fireball.size.width / 2 - (size.width - fireball.size.width) / 2, y: boxHeight * 0.5 + boxMargin)
    
    addChild(fireball)
  }
  
  private func arcaneBoltBox() {
    arcaneBolt.delegate = self
    arcaneBolt.position = CGPoint(x: size.width / 2 - arcaneBolt.size.width / 2 - (size.width-arcaneBolt.size.width) / 2, y: 0)
    
    addChild(arcaneBolt)
  }
  
  private func lightningBoltBox() {
    lightningbolt.delegate = self
    lightningbolt.position = CGPoint(x: size.width/2 - lightningbolt.size.width/2 - (size.width - lightningbolt.size.width)/2, y: -(boxHeight * 0.5 + boxMargin))
    
    addChild(lightningbolt)
  }
  
  private func setActiveSkill(name: SpellString) {
    for skill in skills {
      if skill.spell == name {
        makeSpellActive(skill)
      } else {
        makeSpellInActive(skill)
      }
    }
  }
  
  private func makeSpellActive(skill: SkillButton) {
    skill.color = UIColor.greenColor()
  }
  
  private func makeSpellInActive(skill: SkillButton) {
    skill.color = UIColor.redColor()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
}
