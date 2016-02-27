//
//  Player.swift
//  Borba
//
//  Created by Gabriel Uribe on 7/25/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//


/*
Any player has:
- current experience
- experience required to level up
- level
-

- inventory**

** not to be included in playable demo

*/

import SpriteKit

class Player : Character {
//  var fireballSpell: Spell
  var spellList = [String: Spell]() // fireball is the main skill for demo
  
  var activeSpell: Spell
  
  var activeSpellOnCooldown = false
  
  var mana = 100.0
  var maxMana = 100.0
  var manaRegenRate = 0.12
  var exp = 0.0
  var expToLevel = 100.0
  var level = 1
  var hpRegenRate = 0.01
  var spellDamageModifier = 1.01
  var cooldownModifier = 1.0
  
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    let fireballSpell = Spell(spellDamage: Spell.Damage.fireball, spell: Spell.Name.Fireball, spellCost: Spell.Costs.fireball, spellCooldown: Spell.Cooldowns.fireball)
    let frostboltSpell = Spell(spellDamage: 45, spell: Spell.Name.Frostbolt, spellCost: Spell.Costs.frostbolt, spellCooldown: Spell.Cooldowns.frostbolt)
    let lightningSpell = Spell(spellDamage: 20, spell: Spell.Name.Lightning, spellCost: Spell.Costs.lightning, spellCooldown: Spell.Cooldowns.lightning)
    
    activeSpell = lightningSpell
    spellList[Spell.String.Fireball] = fireballSpell
    spellList[Spell.String.Frostbolt] = frostboltSpell
    spellList[Spell.String.LightningBolt] = lightningSpell
    
    super.init(texture: texture, color: color, size: size)
    health = 100
    maxHealth = 100
    attack = 0.3
    
    setup()
  }

  func levelUp() {
    let greenAction = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 1, duration: 0.5)
    let returnAction = SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1, duration: 0.5)
    runAction(SKAction.sequence([greenAction, returnAction]))
    level += 1
    exp -= expToLevel
    expToLevel *= 1.2
    attack += 0.02
    maxHealth *= 1.05
    maxMana *= 1.05
    health = maxHealth
    mana = maxMana
    hpRegenRate += 0.01
    manaRegenRate += 0.008
    movementSpeed *= 1.02
    spellDamageModifier += 0.01
    cooldownModifier *= 0.96
  }
  
  func setActiveSkill(spell: Spell.Name) {
    switch spell {
    case .Fireball:
      if let spellVar = spellList[Spell.String.Fireball] {
        activeSpell = spellVar
      }
    case .Frostbolt:
      if let spellVar = spellList[Spell.String.Frostbolt] {
        activeSpell = spellVar
      }
    case .Lightning:
      if let spellVar = spellList[Spell.String.LightningBolt] {
        activeSpell = spellVar
      }
    }
  }

  func setup() {
    movementSpeed = 1.75
    activeSpell = spellList[Spell.String.Fireball]!
    
    position = CGPointMake(300, 160)
    zPosition = zPositions.mapObjects;
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.affectedByGravity = false
    physicsBody?.mass = 1
    //physicsBody?.dynamic = false
    physicsBody?.categoryBitMask = CategoryBitMasks.Hero.rawValue
    physicsBody?.collisionBitMask = CategoryBitMasks.Map.rawValue | CategoryBitMasks.Enemy.rawValue
//    shadowCastBitMask = 1
//    shadowedBitMask = 1
    
    setupLightSource()
  }
  
  func setupLightSource() {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiom.Pad) {
      let lightNode = SKLightNode()
      
      lightNode.enabled = true
      lightNode.lightColor = SKColor.whiteColor()
      lightNode.ambientColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
      lightNode.position = CGPointMake(0, 0)
      lightNode.shadowColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.2)
      lightNode.alpha = 1
      lightNode.categoryBitMask = 1
      lightNode.falloff = 0.01
      lightingBitMask = 1
      lightNode.zPosition = zPositions.map
      
      addChild(lightNode)
    }
  }
  
  func handleSpriteMovement(vX: CGFloat, vY: CGFloat, angle: CGFloat) {
    var xPoint: CGFloat
    var yPoint: CGFloat
    
    if (vX > 0 && vY > 0)
    {
      xPoint = CGFloat(movementSpeed * sinf(fabs(Float(angle)))); // player movement_speed
      yPoint = CGFloat(sqrtf(powf(movementSpeed, 2) - powf(Float(xPoint), 2)));
      position = CGPointMake(position.x + xPoint, position.y + yPoint);
    } else if (vX > 0 && vY < 0)
    {
      yPoint = CGFloat(movementSpeed * sinf(fabs(Float(angle) + Float(M_PI/2))));
      xPoint = CGFloat(sqrtf(powf(movementSpeed, 2) - powf(Float(yPoint), 2)));
      position = CGPointMake(position.x + xPoint, position.y - yPoint);
    } else if (vX < 0 && vY < 0)
    {
      yPoint = CGFloat(movementSpeed * sinf(Float(angle) - Float(M_PI/2))); // 2 is movement speed
      xPoint = CGFloat(sqrtf(powf(movementSpeed, 2) - powf(Float(yPoint), 2)));
      position = CGPointMake(position.x - xPoint, position.y - yPoint);
    } else if (vX < 0 && vY > 0)
    {
      xPoint = CGFloat(movementSpeed * sinf(Float(angle)));
      yPoint = CGFloat(sqrtf(powf(movementSpeed, 2) - powf(Float(xPoint), 2)));
      position = CGPointMake(position.x - xPoint, position.y + yPoint);
    } else if (vX < 0 && vY == 0)
    {
      position = CGPointMake(position.x - CGFloat(movementSpeed), position.y);
    } else if (vX > 0 && vY == 0)
    {
      position = CGPointMake(position.x + CGFloat(movementSpeed), position.y);
    } else if (vX == 0 && vY < 0)
    {
      position = CGPointMake(position.x, position.y - CGFloat(movementSpeed));
    } else if (vX == 0 && vY > 0)
    {
      position = CGPointMake(position.x, position.y + CGFloat(movementSpeed));
    }
    
  }
  
  func canUseSpell() -> Bool {
    return !activeSpellOnCooldown && mana > activeSpell.cost
  }
  
  func handlePlayerSpellCast() -> SKSpriteNode {
    let spell = SpellNode.useSpell(activeSpell.spellName, angle: zRotation)
    activeSpellOnCooldown = true
    mana -= activeSpell.cost
    let action = SKAction.sequence([SKAction.waitForDuration(cooldownModifier * activeSpell.cooldown), SKAction.runBlock({
      self.activeSpellOnCooldown = false
    })])
    runAction(action)
    return spell
  }
  
  func changeDirection(angle: CGFloat) {
    //    let rotateAction = SKAction.rotateToAngle(CGFloat(Double(angle) + M_PI), duration: 0.05)
    //    runAction(rotateAction)
    //zRotation = angle;
    zRotation = CGFloat(Double(angle) + M_PI);
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
