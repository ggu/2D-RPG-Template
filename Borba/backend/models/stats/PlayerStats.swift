//
//  PlayerStats.swift
//  Borba
//
//  Created by Gabriel Uribe on 3/9/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

class PlayerStats: Stats {
  private var hpRegenRate = 0.01
  private var manaRegenRate = 0.12
  var attack = 0.15
  var cooldownModifier = 1.0
  var health = 100.0
  var level = 1
  var mana = 100.0
  var maxHealth = 100.0
  var maxMana = 100.0
  var movementSpeed: Float = 1.75
  var spellDamageModifier = 1.01
  
  func regenHealth() {
    if health < maxHealth {
      health += hpRegenRate
    }
  }
  
  func regenMana() {
    if mana < maxMana {
      mana += manaRegenRate
    }
  }
  
  func getRemainingManaFraction() -> Double {
    return mana / maxMana
  }
  
  func getRemainingHealthFraction() -> Double {
    return health / maxHealth
  }
}
