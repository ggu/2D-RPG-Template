//
//  Player.swift
//  Borba
//
//  Created by Gabriel Uribe on 7/25/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class PlayerSprite: Sprite {
  init() {
    let texture = AssetManager.heroTexture
    super.init(texture: texture, color: UIColor.whiteColor(), size: texture.size())
    setup()
  }
  
  func updateDirection(angle: CGFloat) {
    zRotation = angle + CGFloat(M_PI)
  }
  
  private func setup() {
    setupProperties()
    setupPhysics()
    setupLightSource()
  }
  
  private func setupProperties() {
    position = PlayerStartingPosition
    zPosition = zPositions.mapObjects
  }
  
  private func setupPhysics() {
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.affectedByGravity = false
    physicsBody?.mass = 1
    physicsBody?.categoryBitMask = CategoryBitMasks.hero
    physicsBody?.collisionBitMask = CategoryBitMasks.map | CategoryBitMasks.enemy
  }
  
  private func setupLightSource() {
    let lightNode = SKLightNode()
    
    lightNode.enabled = true
    lightNode.lightColor = SKColor.whiteColor()
    lightNode.ambientColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    lightNode.position = CGPoint(x: 0, y: 0)
    lightNode.shadowColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    lightNode.alpha = 1
    lightNode.categoryBitMask = 1
    lightNode.falloff = 0.01
    lightingBitMask = 1
    lightNode.zPosition = zPositions.map
    
    addChild(lightNode)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
}
