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
  
  private init() {}
  
  func generateEnemies(numEnemies: Int) -> [Enemy] {
    for _ in 0..<numEnemies {
      enemies.append(Enemy(texture: AssetManager.sharedInstance.enemyTexture))
    }
    let enemiesList = enemies
    enemies.removeAll()
    return enemiesList
  }
}