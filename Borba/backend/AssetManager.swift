//
//  AssetManager.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/10/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

enum Particle {
  static let Fireball = "Fireball"
  static let ArcaneBolt = "Slimebolt"
  static let LightningStorm = "LightningBall"
  
  static let Rain = "Rain"
  static let Fire = "Fire"
  static let Dissipate = "Dissipate"
  static let LevelUp = "LevelUp"
  static let EnemyDeath = "Death"
}

final class AssetManager {
  private enum ImagePath {
    static let MainMap = "ice.png"
    static let Enemy = "enemy.png"
    static let Hero = "hero.png"
  }
  
  static let sharedInstance = AssetManager()
  
  let heroTexture = SKTexture(imageNamed: ImagePath.Hero)
  let enemyTexture = SKTexture(imageNamed: ImagePath.Enemy)
  let mapTexture = SKTexture(imageNamed: ImagePath.MainMap)
  
  private var arcaneBoltParticles: SKEmitterNode? = nil
  private var fireballParticles: SKEmitterNode? = nil
  private var lightningStormParticles: SKEmitterNode? = nil
  
  private init() {
    arcaneBoltParticles = loadParticles(Particle.ArcaneBolt)
    fireballParticles = loadParticles(Particle.Fireball)
    lightningStormParticles = loadParticles(Particle.LightningStorm)
  }
  
  func getEmitter(particle: String) -> SKEmitterNode? {
    return loadParticles(particle)
  }
  
  // MARK: Spell Assets
  
  func getSpellEmitter(spell: Spell.Name) -> SKEmitterNode? {
    var emitter: SKEmitterNode? = nil
    
    switch spell {
    case .Fireball:
      emitter = fireballParticles?.copy() as? SKEmitterNode
    case .ArcaneBolt:
      emitter = arcaneBoltParticles?.copy() as? SKEmitterNode
    case .Lightning:
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
