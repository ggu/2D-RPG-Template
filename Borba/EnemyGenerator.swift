//
//  EnemyGenerator.swift
//  Borba
//
//  Created by Gabriel Uribe on 1/30/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

class EnemyGenerator {
  static let sharedInstance = EnemyGenerator()
  var enemies: [Enemy] = []
  
  var difficultyCounter = 1
  
  private init() {}
  
  func generateEnemies(numEnemies: Int) -> [Enemy] {
    difficultyCounter += 1
    
    for _ in 0..<numEnemies {
      enemies.append(Enemy(texture: AssetManager.sharedInstance.enemyTexture, difficultyCounter: Double(difficultyCounter)))
    }
    let enemiesList = enemies
    enemies.removeAll()
    return enemiesList
  }
}