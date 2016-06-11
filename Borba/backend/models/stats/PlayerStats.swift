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
  var exp = 0.0
  var expToLevel = 100.0
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
  
  func getRemainingExpFraction() -> Double {
    return exp / expToLevel
  }
  
  func gainExp(exp: Double) {
    self.exp += exp
  }
  
  func levelUp() {
    level += 1
    exp -= expToLevel
    expToLevel *= 1.2
    attack += 0.02
    maxHealth *= 1.05
    maxMana *= 1.05
    health = maxHealth
    mana = maxMana
    hpRegenRate += 0.01
    manaRegenRate += 0.008
    movementSpeed *= 1.02
    spellDamageModifier += 0.01
    cooldownModifier *= 0.96
  }
}
