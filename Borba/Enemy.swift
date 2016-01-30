//
//  Enemy.swift
//  Borba
//
//  Created by Gabriel Uribe on 7/25/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

/*
Any enemy has:
- experience value
- 
*/

import SpriteKit

class Enemy : Character
{
  let expValue: Double
  
  init(texture: SKTexture, difficultyCounter: Double) {
    expValue = ExpValues.enemy + (difficultyCounter - 1.0)
    super.init(texture: texture, color: UIColor.whiteColor(), size: texture.size())
    
    setup()
    movementSpeed = 55.0 + Float(difficultyCounter)
    health = 80 + 4.0 * difficultyCounter
    attack = 0.08 + (difficultyCounter - 1.0) * 0.1
  }
  
  func setup() {
    
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.categoryBitMask = CategoryBitMasks.Enemy.rawValue
    physicsBody?.collisionBitMask = CategoryBitMasks.Hero.rawValue | CategoryBitMasks.Enemy.rawValue
    physicsBody?.contactTestBitMask = CategoryBitMasks.Hero.rawValue
    physicsBody?.affectedByGravity = false
    physicsBody?.restitution = 1
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func handleSpriteMovement(destinationPos: CGPoint) {
    let radians = atan2(destinationPos.y - position.y, destinationPos.x - position.x) + CGFloat(M_PI/2)
    let distance = getDistance(position, point2: destinationPos)
    let action = SKAction.moveTo(destinationPos, duration: distance / Double(movementSpeed))
    runAction(action)
    
    zRotation = radians
  }
  
//  func handleSpriteMovement(destinationPos: CGPoint, offX: CGFloat, offY: CGFloat) {
//    var radians = atan(offY/offX)
//    let xPoint: CGFloat
//    let yPoint: CGFloat
//    
////    if destinationPos.x > position.x && destinationPos.y > position.y {
////      radians += CGFloat(M_PI/2)
////      xPoint = CGFloat(movementSpeed * sin(Float(fabs(radians))))
////      yPoint = CGFloat(movementSpeed * sin(Float(fabs(radians))))
////      
////    }
//  }
  
//  
//  -(void)handleEnemyMovement:(GUEnemy*)enemy player:(GUCharacter*)player offX:(float)offX offY:(float)offY {
//  float radians = atanf(offY/offX);
//  if (player.position.x > enemy.position.x && player.position.y > enemy.position.y) {
//  radians += M_PI/2;
//  float xPoint = enemy.movementSpeed * sinf(fabs(radians));
//  float yPoint = sqrtf(powf(enemy.movementSpeed, 2) - powf(xPoint, 2));
//  enemy.position = CGPointMake(enemy.position.x + xPoint, enemy.position.y + yPoint);
//  } else if (player.position.x > enemy.position.x && player.position.y < enemy.position.y) {
//  radians += M_PI/2;
//  float yPoint = enemy.movementSpeed * sinf(fabs(radians + M_PI/2));
//  float xPoint = sqrtf(powf(enemy.movementSpeed, 2) - powf(yPoint, 2));
//  enemy.position = CGPointMake(enemy.position.x + xPoint, enemy.position.y - yPoint);
//  } else if (player.position.x < enemy.position.x && player.position.y < enemy.position.y) {
//  radians += M_PI*3/2;
//  float yPoint = enemy.movementSpeed * sinf(radians - M_PI/2);
//  float xPoint = sqrtf(powf(enemy.movementSpeed, 2) - powf(yPoint, 2));
//  enemy.position = CGPointMake(enemy.position.x - xPoint, enemy.position.y + yPoint);
//  } else if (player.position.x < enemy.position.x && player.position.y > enemy.position.y) {
//  radians += M_PI*3/2;
//  float xPoint = enemy.movementSpeed * sinf(radians);
//  float yPoint = sqrtf(powf(enemy.movementSpeed, 2) - powf(xPoint, 2));
//  enemy.position = CGPointMake(enemy.position.x + xPoint, enemy.position.y + yPoint);
//  }
//  enemy.zRotation = radians;
//  }
}