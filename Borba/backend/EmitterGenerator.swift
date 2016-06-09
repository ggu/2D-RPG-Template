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
  
  func getEmitter(particle: String, wait1: Double, wait2: Double) -> SKEmitterNode? {
    if let emitter = AssetManager.getEmitter(particle) {
      emitter.zPosition = zPositions.mapObjects
      
      let waitAction = SKAction.waitForDuration(wait1)
      let stopAction = SKAction.runBlock({ emitter.particleBirthRate = 0 })
      let wait2Action = SKAction.waitForDuration(wait2)
      let removeAction = SKAction.removeFromParent()
      emitter.runAction(SKAction.sequence([waitAction, stopAction, wait2Action, removeAction]))
      
      return emitter
    }
    
    return nil
  }
  
  func getDissipationEmitter() -> SKEmitterNode? {
    return getEmitter(Particle.dissipate, wait1: 0.1, wait2: 3)
  }
  
  func getEnemyDeathEmitter() -> SKEmitterNode? {
    return getEmitter(Particle.dissipate, wait1: 0.3, wait2: 2.0)
  }
  
  func getLevelUpEmitter() -> SKEmitterNode? {
    return getEmitter(Particle.dissipate, wait1: 1, wait2: 3)
  }
  
}
