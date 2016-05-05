//
//  Spell.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

struct Spell {
  enum String {
    static let fireball: SpellString = "fireball"
    static let arcaneBolt: SpellString = "arcanebolt"
    static let lightningBolt: SpellString = "lightning"
  }
  
  enum Name {
    case fireball
    case arcaneBolt
    case lightning
  }
  
  enum Damage {
    static let fireball = 100.0
    static let arcaneBolt = 20.0
    static let lightningStorm = 120.0
  }
  
  enum Cooldowns {
    static let fireball = 0.8
    static let arcaneBolt = 0.2
    static let lightningStorm = 1.3
  }
  
  enum Costs {
    static let fireball = 10.0
    static let arcaneBolt = 5.0
    static let lightningStorm = 50.0
  }
  
  enum MissileSpeeds {
    static let fireball = 150.0
    static let arcaneBolt = 200.0
    static let lightningStorm = 80.0
  }
  
  var damage: Double
  var spellName : Name
  var cost: Double
  var cooldown: Double
  
  init(spellDamage: Double, spell : Name, spellCost: Double, spellCooldown: Double) {
    damage = spellDamage
    spellName = spell
    cost = spellCost
    cooldown = spellCooldown
  }
}
