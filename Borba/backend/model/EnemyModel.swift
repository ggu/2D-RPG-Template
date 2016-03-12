//
//  EnemyModel.swift
//  Borba
//
//  Created by Gabriel Uribe on 3/9/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import CoreGraphics

class EnemyModel {

  private var stats: EnemyStats

  init(expValue: Double, difficultyCounter: Int) {
    stats = EnemyStats(expValue: expValue, difficultyCounter: Double(difficultyCounter))
  }
  
  func isEnemyDead() -> Bool {
    return stats.health <= 0
  }
  
  func getMovementSpeed() -> Float {
    return stats.movementSpeed
  }
  
  func takeDamage(damage: Double) {
    stats.health -= damage
  }
  
  func getExpValue() -> Double {
    return stats.expValue
  }
  
  func getAttackValue() -> Double {
    return stats.attack
  }
  
}
