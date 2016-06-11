//
//  EnemyModel.swift
//  Borba
//
//  Created by Gabriel Uribe on 3/9/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import CoreGraphics

class Enemy {
  private var stats: EnemyStats

  init(difficultyCounter: Int) {
    stats = EnemyStats(difficultyCounter: Double(difficultyCounter))
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
  
  func getAttackValue() -> Double {
    return stats.attack
  }
  
}
