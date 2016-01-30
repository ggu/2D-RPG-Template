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
  
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    fireballSpell = Spell(spellDamage: 1, spell: Spells.Fireball, spellCost: SpellCosts.fireball)
    activeSpell = fireballSpell
    spellList.append(fireballSpell)
    super.init(texture: texture, color: color, size: size)
    
    setup()
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
