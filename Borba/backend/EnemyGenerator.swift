//
//  EnemyGenerator.swift
//  Borba
//
//  Created by Gabriel Uribe on 1/30/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

typealias Block = ([EnemySprite]) -> Void

final class EnemyGenerator {
  private var enemies: [EnemySprite] = []
  private var difficultyCounter = 1
  private var numEnemies = 10
  
  private init() {}
  
  class func newGame() -> EnemyGenerator {
    return EnemyGenerator()
  }
  
  func generateEnemies(block: Block) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      self.difficultyCounter += 1
      self.enemies.removeAll()
      
      for _ in 0..<self.numEnemies {
        self.enemies.append(EnemySprite())
      }
      self.incrementNumEnemiesForNextRound()
      
      block(self.enemies)
    })
  }
  
  func incrementNumEnemiesForNextRound() {
    numEnemies = Int(ceil(Double(self.numEnemies) * 1.20))
  }
}
