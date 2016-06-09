//
//  Player.swift
//  Borba
//
//  Created by Gabriel Uribe on 7/25/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class Player: Character {
  init() {
    let texture = AssetManager.heroTexture
    super.init(texture: texture, color: UIColor.whiteColor(), size: texture.size())
    setup()
  }
  
  func changeDirection(angle: CGFloat) {
    zRotation = CGFloat(Double(angle) + M_PI);
  }
  
  func levelUp() {
    let greenAction = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 1, duration: 0.5)
    let returnAction = SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1, duration: 0.5)
    runAction(SKAction.sequence([greenAction, returnAction]))
  }
  
  private func setup() {
    setupProperties()
    setupLightSource()
  }
  
  private func setupProperties() {
    position = PlayerStartingPosition
    zPosition = zPositions.mapObjects;
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.affectedByGravity = false
    physicsBody?.mass = 1
    physicsBody?.categoryBitMask = CategoryBitMasks.hero
    physicsBody?.collisionBitMask = CategoryBitMasks.map | CategoryBitMasks.enemy
  }
  
  private func setupLightSource() {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiom.Pad) {
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
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
