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
  var manaRegenRate = 0.05
  var exp = 0.0
  var expToLevel = 100.0
  var level = 1
  var hpRegenRate = 0.01
  var spellDamageModifier = 1.01
  var cooldownModifier = 1.0
  
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    let fireballSpell = Spell(spellDamage: 50, spell: Spells.Fireball, spellCost: SpellCosts.fireball)
    let frostboltSpell = Spell(spellDamage: 45, spell: Spells.Frostbolt, spellCost: SpellCosts.frostbolt)
    let lightningSpell = Spell(spellDamage: 30, spell: Spells.Lightning, spellCost: SpellCosts.lightning)
    
    activeSpell = lightningSpell
    spellList[SpellStrings.Fireball] = fireballSpell
    spellList[SpellStrings.Frostbolt] = frostboltSpell
    spellList[SpellStrings.LightningBolt] = lightningSpell
    
    super.init(texture: texture, color: color, size: size)
    health = 100
    maxHealth = 100
    attack = 0.4
    
    setup()
  }

  func levelUp() {
    let whitenAction = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 1, duration: 0.5)
    let returnAction = SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1, duration: 0.5)
    runAction(SKAction.sequence([whitenAction, returnAction]))
    level += 1
    exp -= expToLevel
    expToLevel *= 1.2
    attack += 0.05
    maxHealth += 5
    maxMana += 5
    health = maxHealth
    mana = maxMana
    hpRegenRate += 0.01
    manaRegenRate += 0.008
    spellDamageModifier += 0.01
    cooldownModifier *= 0.98
    // increase attack and spell damage
  }
  
  func setActiveSkill(spell: Spells) {
    switch spell {
    case .Fireball:
      if let spellVar = spellList[SpellStrings.Fireball] {
        activeSpell = spellVar
      }
    case .Frostbolt:
      if let spellVar = spellList[SpellStrings.Frostbolt] {
        activeSpell = spellVar
      }
    case .Lightning:
      if let spellVar = spellList[SpellStrings.LightningBolt] {
        activeSpell = spellVar
      }
    }
  }

  func setup() {
    movementSpeed = 2
    activeSpell = spellList[SpellStrings.Fireball]!
    
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
      lightNode.falloff = 0.1
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
    let action = SKAction.sequence([SKAction.waitForDuration(cooldownModifier * 1.0), SKAction.runBlock({
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
