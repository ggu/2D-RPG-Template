//
//  Spell.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class Spell : GameObject {
  var damage : Int = 0
  var spellName : Spells?
  
  init(spellDamage: Int, spell : Spells, texture: SKTexture!)
  {
    damage = spellDamage
    spellName = spell
    
//    switch spellName!
//    {
//    case Spells.Fireball:
//      
//      
//    }
    
    super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(20, 20))
  }
  
  func setupFireBall()
  {
    
  }
  
  func useSpell(angle: CGFloat)
  {
    switch spellName!
    {
    case Spells.Fireball:
      fireBallSpell(angle)
    case Spells.Frostbolt:
      frostBallSpell()
    }
  }
  
  func fireBallSpell(angle: CGFloat)
  {
    if let myParticlePath = NSBundle.mainBundle().pathForResource("Fire", ofType: "sks") {
      let fireParticles = NSKeyedUnarchiver.unarchiveObjectWithFile(myParticlePath) as! SKEmitterNode
      fireParticles.zPosition = zPositions.mapObjects
      fireParticles.position = CGPointMake(0, 0)
      addChild(fireParticles)
    }
    //let action = SKAction.moveByX(<#deltaX: CGFloat#>, y: <#CGFloat#>, duration: <#NSTimeInterval#>)
  }
  
  func frostBallSpell()
  {
    
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
  }
}