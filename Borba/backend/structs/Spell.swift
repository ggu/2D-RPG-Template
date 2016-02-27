//
//  Spell.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

struct Spell {
  enum String {
    static let Fireball: SpellString = "fireball"
    static let ArcaneBolt: SpellString = "arcanebolt"
    static let LightningBolt: SpellString = "lightning"
  }
  
  enum Name {
    case Fireball
    case ArcaneBolt
    case Lightning
  }
  
  enum Damage {
    static let Fireball = 100.0
    static let ArcaneBolt = 20.0
    static let LightningStorm = 120.0
  }
  
  enum Cooldowns {
    static let Fireball = 0.8
    static let ArcaneBolt = 0.2
    static let LightningStorm = 1.0
  }
  
  enum Costs {
    static let Fireball = 10.0
    static let ArcaneBolt = 5.0
    static let LightningStorm = 50.0
  }
  
  enum MissileSpeeds {
    static let Fireball = 150.0
    static let ArcaneBolt = 200.0
    static let LightningStorm = 80.0
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
