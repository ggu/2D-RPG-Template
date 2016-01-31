//
//  SpellNode.swift
//  Borba
//
//  Created by Gabriel Uribe on 1/30/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

class SpellNode: GameObject {
  
  class func useSpell(spell: Spells) -> SKSpriteNode
  {
    switch spell
    {
    case Spells.Fireball:
      return fireBallSpell()
    case Spells.Frostbolt:
      return frostBallSpell()
    case Spells.Lightning:
      return lightningSpell()
    }
  }
  
  class func lightningSpell() -> SKSpriteNode {
    let sprite = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(10, 10))
    
    if let myParticlePath = NSBundle.mainBundle().pathForResource("Lightning", ofType: "sks") {
      let lightningParticles = NSKeyedUnarchiver.unarchiveObjectWithFile(myParticlePath) as! SKEmitterNode
      lightningParticles.particlePositionRange = CGVectorMake(20, 5)
      lightningParticles.zPosition = zPositions.mapObjects
      lightningParticles.position = CGPointMake(0, 0)
      //lightningParticles.pa
      sprite.addChild(lightningParticles)
    }
    
    return sprite
  }
  
  class func fireBallSpell() -> SKSpriteNode
  {
    let sprite = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(10, 10))

    if let myParticlePath = NSBundle.mainBundle().pathForResource("Fire", ofType: "sks") {
      let fireParticles = NSKeyedUnarchiver.unarchiveObjectWithFile(myParticlePath) as! SKEmitterNode
      fireParticles.particlePositionRange = CGVectorMake(20, 5)
      fireParticles.zPosition = zPositions.mapObjects
      fireParticles.position = CGPointMake(0, 0)
      sprite.addChild(fireParticles)
      
      // lightnode performance is really bad in iOS 9, disabled for now
//      let lightNode = SKLightNode()
//      lightNode.enabled = true
//      lightNode.lightColor = SKColor.whiteColor()
//      lightNode.position = CGPointMake(0,0)
//      lightNode.alpha = 0.9
//      lightNode.categoryBitMask = 1
//      lightNode.falloff = 0.4
//      lightNode.zPosition = zPositions.map
      
      //sprite.addChild(lightNode)
    }
    sprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(sprite.size.width*2, sprite.size.height*2))
    sprite.physicsBody?.categoryBitMask = CategoryBitMasks.Spell.rawValue
    sprite.physicsBody?.collisionBitMask = 0
    sprite.physicsBody?.contactTestBitMask = CategoryBitMasks.Enemy.rawValue
    sprite.physicsBody?.affectedByGravity = false
    sprite.physicsBody?.dynamic = false
    return sprite
  }
  
  class func frostBallSpell() -> SKSpriteNode {
    return SKSpriteNode()
  }
  
}
