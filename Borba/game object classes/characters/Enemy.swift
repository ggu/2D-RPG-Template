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

class Enemy : Character {
  let expValue: Double
  var inContactWithPlayer = false
  
  init(texture: SKTexture, difficultyCounter: Double) {
    expValue = ExpValues.enemy + (difficultyCounter - 1.0)
    super.init(texture: texture, color: UIColor.whiteColor(), size: texture.size())
    
    setup()
    movementSpeed = 55.0 + Float(difficultyCounter)
    health = 50 + 4.0 * difficultyCounter
    attack = 0.05 + (difficultyCounter - 1.0) * 0.02
  }
  
  func setup() {
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.categoryBitMask = CategoryBitMasks.Enemy.rawValue
    physicsBody?.collisionBitMask = CategoryBitMasks.Hero.rawValue
    physicsBody?.contactTestBitMask = CategoryBitMasks.Hero.rawValue
    physicsBody?.affectedByGravity = false
    physicsBody?.mass = 100
    lightingBitMask = 1
    shadowCastBitMask = 1
    //shadowedBitMask = 1
    //physicsBody?.dynamic = false
    //physicsBody?.restitution = 1
  }
  
  func handleSpriteMovement(destinationPos: CGPoint) {
    if !inContactWithPlayer {
      let distance = getDistance(position, point2: destinationPos)
      let action = SKAction.moveTo(destinationPos, duration: distance / Double(movementSpeed))
      runAction(action)
    } else {
      removeAllActions()
      //runAction(SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1, duration: 0.5))
    }
    
    let radians = CGFloat(getRadiansBetweenTwoPoints(position, secondPoint: destinationPos))
    zRotation = radians
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}