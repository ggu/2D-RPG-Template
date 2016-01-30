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
  var spellList : NSMutableArray = [Spell(spellDamage: 1, spell: Spells.Fireball)] // fireball is the main skill for demo
  
  var activeSpell : Spell?
    
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
    
    setup()
  }
  
  func setup()
  {
    movementSpeed = 2
    activeSpell = spellList[0] as? Spell
    
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
  
  func handlePlayerSpellCast(angle: CGFloat)
  {
//    activeSpell?.useSpell(angle)
  }
  
  func changeDirection(angle: CGFloat)
  {
//    let rotateAction = SKAction.rotateToAngle(CGFloat(Double(angle) + M_PI), duration: 0.05)
//    runAction(rotateAction)
    //zRotation = angle;
    zRotation = CGFloat(Double(angle) + M_PI);
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
  }
}