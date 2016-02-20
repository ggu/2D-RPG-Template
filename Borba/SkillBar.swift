//
//  SkillBar.swift
//  Borba
//
//  Created by Gabriel Uribe on 1/31/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

protocol SkillBarDelegate {
  func skillButtonTouched(skillName: Spells)
}

class SkillBar: SKSpriteNode, SkillButtonDelegate {
  var currentSkill = Spells.Fireball
  //var skills = []
  var fireball: SkillButton
  var frostbolt: SkillButton
  var lightningbolt: SkillButton
  var skills: [SkillButton]
  let boxHeight: CGFloat
  let boxMargin: CGFloat
  var delegate: SkillBarDelegate?
  
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    boxHeight = size.height / 3 * 0.8
    boxMargin = size.height - (size.height / 3 * 0.8)*3
    
    fireball = SkillButton(spell: Spells.Fireball, color: UIColor.redColor(), size: CGSizeMake(size.width*0.9, boxHeight))
    frostbolt = SkillButton(spell: Spells.Frostbolt, color: UIColor.redColor(), size: CGSizeMake(size.width*0.9, boxHeight))
    lightningbolt = SkillButton(spell: Spells.Lightning, color: UIColor.redColor(), size: CGSizeMake(size.width*0.9, boxHeight))
    skills = [fireball, frostbolt, lightningbolt]
    
    super.init(texture: texture, color: color, size: size)
    
    setup()
  }
  
  func setup() {
    alpha = 0.6
    fireBallBox()
    frostBallBox()
    lightningBoltBox()
    makeSpellActive(fireball)
  }
  
  func fireBallBox() {
    
    fireball.delegate = self
    fireball.position = CGPointMake(size.width/2-fireball.size.width/2 - (size.width-fireball.size.width)/2, boxHeight*0.5 + boxMargin)
    
    addChild(fireball)
  }
  
  func frostBallBox() {
    frostbolt.delegate = self
    frostbolt.position = CGPointMake(size.width/2-frostbolt.size.width/2 - (size.width-frostbolt.size.width)/2, 0)
    
    addChild(frostbolt)
  }
  
  func lightningBoltBox() {
    lightningbolt.delegate = self
    lightningbolt.position = CGPointMake(size.width/2-lightningbolt.size.width/2 - (size.width-lightningbolt.size.width)/2, -(boxHeight*0.5 + boxMargin))
    
    addChild(lightningbolt)
  }
  
  func skillButtonTouched(skillName: Spells) {
    
    // protocol call level
    currentSkill = skillName
    
    setActiveSkill(currentSkill)
    
    delegate?.skillButtonTouched(skillName)
  }
  
  func setActiveSkill(name: Spells) {
    for skill in skills {
      if skill.spell == name {
        makeSpellActive(skill)
      } else {
        makeSpellInActive(skill)
      }
    }
  }
  
  func makeSpellActive(skill: SkillButton) {
    skill.color = UIColor.greenColor()
  }
  
  func makeSpellInActive(skill: SkillButton) {
    skill.color = UIColor.redColor()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
}