//
//  Enemy.swift
//  Borba
//
//  Created by Gabriel Uribe on 7/25/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class EnemySprite: Sprite {
  var inContactWithPlayer = false
  
  init() {
    let texture = AssetManager.enemyTexture
    super.init(texture: texture, color: UIColor.whiteColor(), size: texture.size())
    setup()
  }
  
  func handleSpriteMovement(destinationPos: CGPoint, duration: Double) {
    if !inContactWithPlayer {
      let action = SKAction.moveTo(destinationPos, duration: duration)
      runAction(action)
    } else {
      removeAllActions()
    }
    
    zRotation = CGFloat(getRadiansBetweenTwoPoints(position, secondPoint: destinationPos))
  }
  
  private func setup() {
    name = String(ObjectIdentifier(self).uintValue)
    setupProperties()
  }
  
  private func setupProperties() {
    zPosition = zPositions.mapObjects
    physics()
    lightingBitMask = 1
    shadowCastBitMask = 1
  }
  
  private func physics() {
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.categoryBitMask = CategoryBitMasks.enemy
    physicsBody?.collisionBitMask = CategoryBitMasks.hero
    physicsBody?.contactTestBitMask = CategoryBitMasks.hero
    physicsBody?.affectedByGravity = false
    physicsBody?.mass = 100
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
}
