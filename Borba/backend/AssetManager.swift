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
  
  static let sharedInstance = AssetManager()
  
  let heroTexture = SKTexture(imageNamed: ImagePath.hero)
  let enemyTexture = SKTexture(imageNamed: ImagePath.enemy)
  let mapTexture = SKTexture(imageNamed: ImagePath.mainMap)
  
  private var arcaneBoltParticles: SKEmitterNode? = nil
  private var fireballParticles: SKEmitterNode? = nil
  private var lightningStormParticles: SKEmitterNode? = nil
  
  private init() {
    arcaneBoltParticles = loadParticles(Particle.arcaneBolt)
    fireballParticles = loadParticles(Particle.fireball)
    lightningStormParticles = loadParticles(Particle.lightningStorm)
  }
  
  func getEmitter(particle: String) -> SKEmitterNode? {
    return loadParticles(particle)
  }
  
  // MARK: Spell Assets
  
  func getSpellEmitter(spell: Spell.Name) -> SKEmitterNode? {
    var emitter: SKEmitterNode? = nil
    
    switch spell {
    case .fireball:
      emitter = fireballParticles?.copy() as? SKEmitterNode
    case .arcaneBolt:
      emitter = arcaneBoltParticles?.copy() as? SKEmitterNode
    case .lightning:
      emitter = lightningStormParticles?.copy() as? SKEmitterNode
    }
    
    return emitter
  }
  
  // MARK: Utilities
  private func loadParticles(resource: String) -> SKEmitterNode? {
    var particles: SKEmitterNode? = nil
    if let myParticlePath = NSBundle.mainBundle().pathForResource(resource, ofType: "sks") {
      particles = NSKeyedUnarchiver.unarchiveObjectWithFile(myParticlePath) as! SKEmitterNode?
    }
    return particles
  }

}
