//
//  EnemyModelExtension.swift
//  Borba
//
//  Created by Gabriel Uribe on 3/6/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import CoreGraphics

protocol EnemiesModelDelegate {
  func enemyDeathSequence(id: EnemyID)
}

class EnemiesModel {
  private enum ExpValue {
    static let enemy = 10.0
  }
  
  var delegate: EnemiesModelDelegate?
  
  private var enemies = [EnemyID: EnemyModel]()
  private var difficultyCounter = 1
  
  private init() {}
  
  class func newGame() -> EnemiesModel {
    return EnemiesModel()
  }
  
  func addEnemy(id: EnemyID) {
    enemies[id] = EnemyModel(expValue: ExpValue.enemy, difficultyCounter: difficultyCounter)
  }
  
  func removeEnemy(id: EnemyID) {
    enemies.removeValueForKey(id)
  }
  
  func takeDamage(id: EnemyID, damage: Double) {
    if let enemy = enemies[id] {
      enemy.takeDamage(damage)
      checkForDeath(enemy, id: id)
    }
  }
  
  func incrementDifficulty() {
    difficultyCounter += 1
  }
  
  func checkForDeath(enemy: EnemyModel, id: EnemyID) {
    if enemy.isEnemyDead() {
      removeEnemy(id)
      delegate?.enemyDeathSequence(id)
    }
  }
  
  func getAttackValue(id: EnemyID) -> Double {
    let attackValue: Double
    if let enemy = enemies[id] {
      attackValue = enemy.getAttackValue()
    } else {
      attackValue = 1
    }
    
    return attackValue
  }
  
  func getExpValue(id: EnemyID) -> Double {
    let expValue: Double
    if let enemy = enemies[id] {
      expValue = enemy.getExpValue()
    } else {
      expValue = ExpValue.enemy
    }
    
    return expValue
  }
  
  func newRound(enemies: [EnemyID]) {
    difficultyCounter += 1
  }
  
  func getMovementSpeed(id: EnemyID) -> Float {
    let movementSpeed: Float
    if let enemy = enemies[id] {
      movementSpeed = enemy.getMovementSpeed()
    } else {
      movementSpeed = 100 // return default instead
    }
    return movementSpeed
  }
  
  /**
   Get a new enemy position that is not within a frame around the player on the map
  */
  func getEnemySpawnPosition(playerPosition: CGPoint, mapSize: CGSize) -> CGPoint {
    let safeFrame = CGRect(x: playerPosition.x - 400, y: playerPosition.y - 400, width: 800, height: 800)
    var xpos = getRandomNumber(mapSize.width)
    var ypos = getRandomNumber(mapSize.height)
    
    while (safeFrame.contains(CGPoint(x: xpos, y: ypos))) {
      xpos = getRandomNumber(mapSize.width)
      ypos = getRandomNumber(mapSize.height)
    }
    return CGPoint(x: xpos, y: ypos)
  }
}
