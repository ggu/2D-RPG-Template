//
//  LevelOne.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/22/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

final class LevelOne: SKScene, SKPhysicsContactDelegate {
  let cameraNode = CameraNode()
  let map = MapSprite(map: MapSprite.Level.demo)
  let hud: HUD
  var enemies: [EnemySprite] = []
  var playerEnemyInContact = false
  var enemiesInContact: [EnemySprite] = []
  var enemiesKilled = 0
  let unitManager = UnitManager.newGame()
  var enemiesModel = Enemies.newGame()
  var enemyGenerator = EnemyGenerator.newGame()
  
  override init(size: CGSize) {
    hud = HUD(size: size)
    
    super.init(size: size)
  }
  
  // MARK: Setup functions
  override func didMoveToView(view: SKView) {
    newGame()
  }
  
  private func newGame() {
    setupProperties()
    setupMap()
    setupHUD()
    setupPlayer()
    setupBackgroundMusic()
    setupCamera()
    loadEnemies()
  }
  
  private func setupBackgroundMusic() {
    runAction(SKAction.repeatActionForever(SKAction.playSoundFileNamed(SoundFile.music, waitForCompletion: true)))
  }
  
  private func loadEnemies() {
    enemyGenerator.generateEnemies({ (enemies: [EnemySprite]) in
      self.spawnEnemies(enemies)
    })
  }
  
  private func setupHUD() {
    hud.delegate = self
    addChild(hud)
  }
  
  private func setupMap() {
    self.addChild(map)
  }
  
  private func setupProperties() {
    unitManager.delegate = self
    enemiesModel.delegate = self
    view?.multipleTouchEnabled = true
    physicsWorld.contactDelegate = self
  }
  
  private func setupPlayer() {
    map.addChild(unitManager.player.sprite)
  }
  
  private func setupCamera() {
    map.addChild(cameraNode)
  }
  
  // MARK: - Update
  override func update(currentTime: CFTimeInterval) {
    updatePlayerState()
    updateEnemies()
    updatePlayerEnemyConditions()
  }
  
  // MARK: - Physics functions
  
  override func didSimulatePhysics() {
    updateCamera()
  }
  
  func didBeginContact(contact: SKPhysicsContact) {
    let bodyA = contact.bodyA
    let bodyB = contact.bodyB
    
    handleGameObjectContact(bodyA, bodyB: bodyB)
    hud.updateHealthFrame(unitManager.player.getRemainingHealthFraction())
  }
  
  func didEndContact(contact: SKPhysicsContact) {
    let bodyA = contact.bodyA
    let bodyB = contact.bodyB
    
    if bodyA.categoryBitMask == CategoryBitMasks.hero {
      if let enemy = bodyB.node as? EnemySprite {
        contactEnded(enemy)
      }
    } else if bodyB.categoryBitMask == CategoryBitMasks.hero {
      if let enemy = bodyA.node as? EnemySprite {
        contactEnded(enemy)
      }
    }
  }
  
  private func contactEnded(enemy: EnemySprite) {
    enemy.inContactWithPlayer = false
    removeEnemyFromEnemiesInContact(enemy)
    
    if !enemiesAreInContact() {
      playerEnemyInContact = false
    }
  }
  
  private func handleGameObjectContact(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
    if bodyA.categoryBitMask == CategoryBitMasks.hero {
      handlePlayerAndEnemyContact(bodyB.node)
    } else if bodyB.categoryBitMask == CategoryBitMasks.hero {
      handlePlayerAndEnemyContact(bodyA.node)
    } else if bodyA.categoryBitMask == CategoryBitMasks.spell {
      handleSpellAndEnemyContact(bodyB.node, spellNode: bodyA.node, penetrates: false)
    } else if bodyB.categoryBitMask == CategoryBitMasks.spell {
      handleSpellAndEnemyContact(bodyA.node, spellNode: bodyB.node, penetrates: false)
    } else if bodyA.categoryBitMask == CategoryBitMasks.penetratingSpell {
      handleSpellAndEnemyContact(bodyB.node, spellNode: nil, penetrates: true)
    } else if bodyB.categoryBitMask == CategoryBitMasks.penetratingSpell {
      handleSpellAndEnemyContact(bodyA.node, spellNode: nil, penetrates: true)
    }
  }
  
  // MARK: - Player and Enemy High Level Logic
  
  private func updateEnemies() {
      for enemy in enemies {
        let distance = getDistance(enemy.position, point2: unitManager.player.sprite.position)
        enemy.handleSpriteMovement(unitManager.player.sprite.position, duration: distance / Double(enemiesModel.getMovementSpeed(enemy.name!)))
      }
  }
  
  private func updatePlayerState() {
    unitManager.regenPlayerResources()
    playerJoystickUpdate()
    updateHUD()
  }
  
  private func playerJoystickUpdate() {
    let (moveJoystickValues, skillJoystickValues) = hud.getJoystickValues()
    unitManager.playerJoysticsUpdate(moveJoystickValues, skillJoystickValues: skillJoystickValues)

  }
  
  private func updateHUD() {
    hud.updateEnergyFrame(unitManager.player.getRemainingManaFraction())
    hud.updateHealthFrame(unitManager.player.getRemainingHealthFraction())
  }
  
  private func updatePlayerEnemyConditions() {
    if playerEnemyInContact {
      for enemy in enemiesInContact {
        damagePlayer(enemy)
      }
    }
  }
  
  private func spawnEnemies(enemies: [EnemySprite]) {
    var enemies = enemies
    if enemies.count >= 1 {
      let spawnAction = SKAction.runBlock({
        if let enemy = enemies.popLast() {
          self.enemiesModel.addEnemy(enemy.name!)
          enemy.position = self.enemiesModel.getEnemySpawnPosition(self.unitManager.player.sprite.position, mapSize: self.map.size)
          self.enemies.append(enemy)
          self.map.addChild(enemy)
        }
      })
      let waitAction = SKAction.waitForDuration(Double(getRandomNumber(30) / 50))
      let spawnMoreAction = SKAction.runBlock({
        self.spawnEnemies(enemies)
      })
      
      let sequence = SKAction.sequence([spawnAction, waitAction, spawnMoreAction])
      runAction(sequence)
    }
  }
  
  private func handleSpellAndEnemyContact(enemyNode: SKNode?, spellNode: SKNode?, penetrates: Bool) {
    if let enemy = enemyNode as? EnemySprite {
      if !penetrates {
        let spell = spellNode as? SpellNode
        spell?.fizzleOut()
      }
      onSpellHitEffects(enemy.position)
      enemiesModel.takeDamage(enemy.name!, damage: unitManager.player.activeSpell.damage * unitManager.player.getSpellDamageModifier())
    }
  }
  
  private func handlePlayerAndEnemyContact(enemyNode: SKNode?) {
    if let enemy = enemyNode as? EnemySprite {
      damagePlayer(enemy)
      putEnemyInContact(enemy)
    }
  }
  
  private func putEnemyInContact(enemy: EnemySprite) {
    if !enemiesInContact.contains(enemy) {
      enemiesInContact.append(enemy)
    }
    
    enemy.inContactWithPlayer = true
    playerEnemyInContact = true
  }
  
  
  // MARK: - Player and Enemy Death Helpers
  private func removeEnemyFromEnemiesInContact(enemy: EnemySprite) {
    if enemiesInContact.contains(enemy) {
      if let index = enemiesInContact.indexOf(enemy) {
        enemiesInContact.removeAtIndex(index)
        if enemiesInContact.isEmpty {
          playerEnemyInContact = false
        }
      }
    }
  }
  
  private func animateDeath(position: CGPoint) {
    if let deathEmitter = EmitterGenerator.getEnemyDeathEmitter() {
      deathEmitter.position = position
      map.addChild(deathEmitter)
    }
  }
  
  // MARK: - Low level calculations/helpers

  private func enemiesAreInContact() -> Bool {
    return !enemiesInContact.isEmpty
  }
  
  // MARK: Player damage
  private func damagePlayer(enemy: EnemySprite) {
    unitManager.player.takeDamage(enemiesModel.getAttackValue(enemy.name!))
  }
  
  // MARK: - Player and Enemy Visuals
  private func onSpellHitEffects(position: CGPoint) {
    if let dissipateEmitter = EmitterGenerator.getDissipationEmitter() {
      map.addChild(dissipateEmitter, position: position)
    }
  }
  
  // MARK: - Camera
  private func updateCamera() {
    let playerX = unitManager.player.sprite.position.x
    let playerY = unitManager.player.sprite.position.y
    
    if (playerX > size.width / 2 && playerX < (map.size.width - size.width / 2)) {
      self.cameraNode.position = CGPoint(x: playerX - frame.size.width / 2, y: cameraNode.position.y);
    }
    if (playerY > frame.size.height / 2 && playerY < (map.size.height - size.height / 2)) {
      self.cameraNode.position = CGPoint(x: cameraNode.position.x, y: playerY - size.height / 2);
    }
    
    cameraNode.center()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Extensions
extension LevelOne: HUDDelegate {
  func skillButtonTouched(skillName: SpellString) {
    unitManager.player.setActiveSkill(skillName)
  }
}

extension LevelOne: UnitManagerDelegate {
  func playerCastSpell(spell: SKSpriteNode) {
    map.addChild(spell)
  }
  
  func playerDeath() {
    let scene = MainMenu(size: view!.bounds.size)
    
    scene.scaleMode = .ResizeFill
    view!.presentScene(scene, transition: SKTransition.crossFadeWithDuration(1.0))
  }
}

extension LevelOne: EnemiesDelegate {
  func enemyDeathSequence(id: EnemyID) {
    for enemy in enemies {
      if enemy.name! == id {
        enemyDeathSequence(enemy)
      }
    }
  }
  
  private func enemyDeathSequence(enemy: EnemySprite) {
    runAction(SKAction.playSoundFileNamed(SoundFile.zombieDeath, waitForCompletion: false))
    enemyDeath(enemy)
    updateGameStateAfterEnemyDeath()
  }
  
  private func updateGameStateAfterEnemyDeath() {
    enemiesKilled += 1
    checkIfBeginNextRound()
    hud.updateKillCount(enemiesKilled)
  }
  
  private func checkIfBeginNextRound() {
    if enemies.isEmpty {
      enemiesModel.incrementDifficulty()
      let waitAction = SKAction.waitForDuration(4)
      let spawnAction = SKAction.runBlock({
        self.loadEnemies()
      })
      
      let sequence = SKAction.sequence([waitAction, spawnAction])
      runAction(sequence)
    }
  }
  
  private func enemyDeath(enemy: EnemySprite) {
    animateDeath(enemy.position)
    
    removeEnemyFromEnemiesInContact(enemy)
    
    if let index = enemies.indexOf(enemy) {
      enemies.removeAtIndex(index)
    }
    
    enemy.physicsBody = nil
    enemy.runAction(SKAction.fadeOutWithDuration(0.2))
  }
}
