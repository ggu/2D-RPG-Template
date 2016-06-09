//
//  AssetManager.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/10/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

enum Particle {
  static let fireball = "Fireball"
  static let arcaneBolt = "Slimebolt"
  static let lightningStorm = "LightningBall"
  
  static let rain = "Rain"
  static let fire = "Fire"
  static let dissipate = "Dissipate"
  static let levelUp = "LevelUp"
  static let enemyDeath = "Death"
}

final class AssetManager {
  private enum ImagePath {
    static let mainMap = "ice.png"
    static let enemy = "enemy.png"
    static let hero = "hero.png"
  }
  
  static let heroTexture = SKTexture(imageNamed: ImagePath.hero)
  static let enemyTexture = SKTexture(imageNamed: ImagePath.enemy)
  static let mapTexture = SKTexture(imageNamed: ImagePath.mainMap)
  
  private static var arcaneBoltParticles = AssetManager.loadParticles(Particle.arcaneBolt)
  private static var fireballParticles = AssetManager.loadParticles(Particle.fireball)
  private static var lightningStormParticles = AssetManager.loadParticles(Particle.lightningStorm)
  
  static func getEmitter(particle: String) -> SKEmitterNode? {
    return AssetManager.loadParticles(particle)
  }
  
  // MARK: Spell Assets
  
  static func getSpellEmitter(spell: Spell.Name) -> SKEmitterNode? {
    var emitter: SKEmitterNode? = nil
    
    switch spell {
    case .fireball:
      emitter = AssetManager.fireballParticles?.copy() as? SKEmitterNode
    case .arcaneBolt:
      emitter = AssetManager.arcaneBoltParticles?.copy() as? SKEmitterNode
    case .lightning:
      emitter = AssetManager.lightningStormParticles?.copy() as? SKEmitterNode
    }
    
    return emitter
  }
  
  // MARK: Utilities
  private static func loadParticles(resource: String) -> SKEmitterNode? {
    var particles: SKEmitterNode? = nil
    if let myParticlePath = NSBundle.mainBundle().pathForResource(resource, ofType: "sks") {
      particles = NSKeyedUnarchiver.unarchiveObjectWithFile(myParticlePath) as! SKEmitterNode?
    }
    return particles
  }

}
