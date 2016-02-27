//
//  EmitterGenerator.swift
//  Borba
//
//  Created by Gabriel Uribe on 3/7/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

class EmitterGenerator {
  static let sharedInstance = EmitterGenerator()
  
  func getDissipationEmitter() -> SKEmitterNode? {
    if let dissipateEmitter = AssetManager.sharedInstance.getEmitter(Particle.Dissipate) {
      dissipateEmitter.zPosition = zPositions.MapObjects
      
      let waitAction = SKAction.waitForDuration(0.1)
      let stopAction = SKAction.runBlock({
        dissipateEmitter.particleBirthRate = 0
      })
      let wait2Action = SKAction.waitForDuration(3)
      let removeAction = SKAction.removeFromParent()
      dissipateEmitter.runAction(SKAction.sequence([waitAction, stopAction, wait2Action, removeAction]))
      
      return dissipateEmitter
    }

    return nil
  }
  
  func getEnemyDeathEmitter() -> SKEmitterNode? {
    if let deathEmitter = AssetManager.sharedInstance.getEmitter(Particle.EnemyDeath) {
      deathEmitter.zPosition = zPositions.MapObjects
      
      let waitAction = SKAction.waitForDuration(0.3)
      let stopAction = SKAction.runBlock({
        deathEmitter.particleBirthRate = 0
      })
      let wait2Action = SKAction.waitForDuration(2.0)
      let removeAction = SKAction.removeFromParent()
      deathEmitter.runAction(SKAction.sequence([waitAction, stopAction, wait2Action, removeAction]))
      
      return deathEmitter
    }
    
    return nil
  }
  
  func getLevelUpEmitter() -> SKEmitterNode? {
    if let levelUpEmitter = AssetManager.sharedInstance.getEmitter(Particle.LevelUp) {
      levelUpEmitter.zPosition = zPositions.MapObjects
      
      let waitAction = SKAction.waitForDuration(1)
      let stopAction = SKAction.runBlock({
        levelUpEmitter.particleBirthRate = 0
      })
      let wait2Action = SKAction.waitForDuration(3)
      let removeAction = SKAction.removeFromParent()
      levelUpEmitter.runAction(SKAction.sequence([waitAction, stopAction, wait2Action, removeAction]))
      
      return levelUpEmitter
    }
    
    return nil
  }
  
}
