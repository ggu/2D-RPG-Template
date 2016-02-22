//
//  Spell.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

struct Spell {
  enum String {
    static let Fireball = "fireball"
    static let Frostbolt = "frostbolt"
    static let LightningBolt = "lightning"
  }
  enum Name {
    case Fireball
    case Frostbolt
    case Lightning
  }
  enum Damage {
    static let fireball = 100.0
    static let frostbolt = 26.0
    static let lightning = 10.0
  }
  
  enum Cooldowns {
    static let fireball = 1.1
    static let frostbolt = 0.5
    static let lightning = 0.3
  }
  
  enum Costs {
    static let fireball = 15.0
    static let frostbolt = 8.0
    static let lightning = 10.0
  }
  
  enum MissileSpeeds {
    static let fireball = 200.0
    static let frostbolt = 250.0
    static let lightning = 100.0
  }
  
  var damage: Double
  var spellName : Name
  var cost: Double
  var cooldown: Double
  
  init(spellDamage: Double, spell : Name, spellCost: Double, spellCooldown: Double)
  {
    damage = spellDamage
    spellName = spell
    cost = spellCost
    cooldown = spellCooldown
  }
}
