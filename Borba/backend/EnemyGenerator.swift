//
//  EnemyGenerator.swift
//  Borba
//
//  Created by Gabriel Uribe on 1/30/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

final class EnemyGenerator {
  private var enemies: [Enemy] = []
  private var difficultyCounter = 1
  private var numEnemies = 10
  
  private init() {}
  
  class func newGame() -> EnemyGenerator {
    return EnemyGenerator()
  }
  
  func generateEnemies() -> [Enemy] {
    difficultyCounter += 1
    enemies.removeAll()
    
    for _ in 0..<numEnemies {
      enemies.append(Enemy())
    }
    incrementNumEnemiesForNextRound()
    
    return enemies
  }
  
  func incrementNumEnemiesForNextRound() {
    numEnemies = Int(ceil(Double(self.numEnemies) * 1.20))
  }
}
