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

class Player : Character
{
  var fireballSpell: Spell
  var spellList: [Spell] = [] // fireball is the main skill for demo
  
  var activeSpell: Spell
  
  var activeSpellOnCooldown = false
  
  var mana = 100.0
  var maxMana = 100.0
  var manaRegenRate = 0.05
  var exp = 0.0
  var expToLevel = 100.0
  var level = 1
  var hpRegenRate = 0.02
  var spellDamageModifier = 1.02
  
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    fireballSpell = Spell(spellDamage: 1, spell: Spells.Fireball, spellCost: SpellCosts.fireball)
    activeSpell = fireballSpell
    spellList.append(fireballSpell)
    super.init(texture: texture, color: color, size: size)
    health = 100
    maxHealth = 100
    attack = 0.8
    
    setup()
  }

  func levelUp() {
    
    let whitenAction = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 1, duration: 0.5)
    let returnAction = SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1, duration: 0.5)
    runAction(SKAction.sequence([whitenAction, returnAction]))
    level += 1
    exp -= expToLevel
    expToLevel *= 1.2
    attack += 0.1
    maxHealth += 5
    maxMana += 5
    health = maxHealth
    mana = maxMana
    hpRegenRate += 0.01
    manaRegenRate += 0.02
    spellDamageModifier += 0.02
    // increase attack and spell damage
  }
  

  func setup()
  {
    movementSpeed = 2
    activeSpell = spellList[0]
    
    position = CGPointMake(300, 160)
    zPosition = zPositions.mapObjects;
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.affectedByGravity = false
    physicsBody?.categoryBitMask = CategoryBitMasks.Hero.rawValue
    physicsBody?.collisionBitMask = CategoryBitMasks.Map.rawValue
    lightingBitMask = 1
    shadowCastBitMask = 1
    shadowedBitMask = 1
    
  }
  
  func handleSpriteMovement(vX: CGFloat, vY: CGFloat, angle: CGFloat)
  {
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
  
  func handlePlayerSpellCast() -> SKSpriteNode
  {
    let spell = SpellNode.useSpell(activeSpell.spellName)
    activeSpellOnCooldown = true
    mana -= activeSpell.cost
    let action = SKAction.sequence([SKAction.waitForDuration(1.0), SKAction.runBlock({
      self.activeSpellOnCooldown = false
    })])
    runAction(action)
    return spell
  }
  
  func changeDirection(angle: CGFloat)
  {
    //    let rotateAction = SKAction.rotateToAngle(CGFloat(Double(angle) + M_PI), duration: 0.05)
    //    runAction(rotateAction)
    //zRotation = angle;
    zRotation = CGFloat(Double(angle) + M_PI);
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
