//
//  EnemyStats.swift
//  Borba
//
//  Created by Gabriel Uribe on 3/9/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

class EnemyStats: Stats {
  
  let expValue: Double
  var attack = 0.3
  var health = 100.0
  var maxHealth = 100.0
  var movementSpeed: Float = 1.75
  
  init(expValue: Double, difficultyCounter: Double) {
    self.expValue = expValue
    self.movementSpeed = 55.0 + Float(difficultyCounter)
    self.health = 50 + 4.0 * difficultyCounter
    self.attack = 0.05 + (difficultyCounter - 1.0) * 0.02
  }
  
}
