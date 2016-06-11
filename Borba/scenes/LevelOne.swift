//
//  LevelOne.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/22/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

final class LevelOne: SKScene, SKPhysicsContactDelegate {
  var width: CGFloat
  var height: CGFloat
  let player = PlayerSprite()
  let cameraNode = CameraNode()
  let map = MapSprite(map: MapSprite.Level.demo)
  let hud: HUD
  var enemies: [EnemySprite] = []
  var playerEnemyInContact = false
  var enemiesInContact: [EnemySprite] = []
  var enemiesKilled = 0
  var playerModel = Player.newGame()
  var enemiesModel = Enemies.newGame()
  var enemyGenerator = EnemyGenerator.newGame()
  
  override init(size: CGSize) {
    hud = HUD(size: size)
    width = size.width
    height = size.height
    super.init(size: size)
  }
  
  // MARK: Setup functions
  override func didMoveToView(view: SKView) {
    setup()
  }
  
  private func setup() {
    setupProperties()
    setupMap()
    setupHUD()
    setupPlayer()
    runAction(SKAction.repeatActionForever(SKAction.playSoundFileNamed(SoundFile.music, waitForCompletion: true)))
    setupCamera()
    loadEnemies()
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
    playerModel.delegate = self
    enemiesModel.delegate = self
    view?.multipleTouchEnabled = true
    physicsWorld.contactDelegate = self
  }
  
  private func setupPlayer() {
    map.addChild(player)
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
    hud.updateHealthFrame(playerModel.getRemainingHealthFraction())
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
        let distance = getDistance(enemy.position, point2: player.position)
        enemy.handleSpriteMovement(player.position, duration: distance / Double(enemiesModel.getMovementSpeed(enemy.name!)))
      }
  }
  
  private func updatePlayerState() {
    regenPlayerResources()
    
    let (moveJoystickValues, skillJoystickValues) = hud.getJoystickValues()
    player.position = playerModel.getNewPlayerPosition(moveJoystickValues.0, vY: moveJoystickValues.1, angle: moveJoystickValues.2, pos: player.position)
    if (skillJoystickValues.0 == 0 && skillJoystickValues.1 == 0) {
      player.updateDirection(moveJoystickValues.2)
    } else {
      player.updateDirection(skillJoystickValues.2)
      if playerModel.canUseSpell() {
        useSpell()
      }
    }
    
    hud.updateEnergyFrame(playerModel.getRemainingManaFraction())
    hud.updateHealthFrame(playerModel.getRemainingHealthFraction())
  }
  
  private func updatePlayerEnemyConditions() {
    if playerEnemyInContact {
      for enemy in enemiesInContact {
        damagePlayerAndEnemy(enemy)
      }
    }
  }
  
  private func spawnEnemies(enemies: [EnemySprite]) {
    var enemies = enemies
    if enemies.count >= 1 {
      let spawnAction = SKAction.runBlock({
        if let enemy = enemies.popLast() {
          self.enemiesModel.addEnemy(enemy.name!)
          enemy.position = self.enemiesModel.getEnemySpawnPosition(self.player.position, mapSize: self.map.size)
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
      enemiesModel.takeDamage(enemy.name!, damage: playerModel.activeSpell.damage * playerModel.getSpellDamageModifier())
    }
  }
  
  private func handlePlayerAndEnemyContact(enemyNode: SKNode?) {
    if let enemy = enemyNode as? EnemySprite {
      damagePlayerAndEnemy(enemy)
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
  
  // MARK: - Spells
  
  private func useSpell() {
    let spellSprite: SKSpriteNode
    let action: SKAction
    (spellSprite, action) = playerModel.handleSpellCast(player.zRotation)
    spellSprite.position = player.position
    player.runAction(action)
    
    switch playerModel.activeSpell.spellName {
    case .lightning:
      useLinearSpell(spellSprite, missileSpeed: Spell.MissileSpeeds.lightningStorm)
    case .fireball:
      useLinearSpell(spellSprite, missileSpeed: Spell.MissileSpeeds.fireball)
    case .arcaneBolt:
      useLinearSpell(spellSprite, missileSpeed: Spell.MissileSpeeds.arcaneBolt)
    }
    map.addChild(spellSprite)
  }
  
  private func useLinearSpell(spell: SKSpriteNode, missileSpeed: Double) {
    var sign = 1
    if hud.skillJoystick.thumbX < 0 {
      sign = -1
    }
    let angle = getAngle(hud.skillJoystick.thumbY, adjacent: hud.skillJoystick.thumbX)
    let (dx,dy) = getTriangleLegs(1000, angle: angle, sign: CGFloat(sign))
    
    let arbitraryPointFaraway = CGPoint(x: spell.position.x + dx, y: spell.position.y + dy)
    let duration = getDistance(spell.position, point2: arbitraryPointFaraway) / missileSpeed
    
    let moveAction = SKAction.moveTo(arbitraryPointFaraway, duration: duration)
    let removeAction = SKAction.removeFromParent()
    let completeAction = SKAction.sequence([moveAction, removeAction])
    spell.runAction(completeAction)
  }
  
  // MARK: - Low level calculations/helpers
  
  private func regenPlayerResources() {
    playerModel.regenMana()
    playerModel.regenHealth()
  }
  
  private func enemiesAreInContact() -> Bool {
    return !enemiesInContact.isEmpty
  }
  
  // MARK: Player and Enemy damage
  
  private func damagePlayerAndEnemy(enemy: EnemySprite) {
    playerModel.takeDamage(enemiesModel.getAttackValue(enemy.name!))
    enemiesModel.takeDamage(enemy.name!, damage: playerModel.getAttack())

  }
  
  // MARK: - Player and Enemy Visuals
  
  private func onSpellHitEffects(position: CGPoint) {
    if let dissipateEmitter = EmitterGenerator.getDissipationEmitter() {
      map.addChild(dissipateEmitter, position: position)
    }
  }
  
  private func levelUpEffects() {
    if let levelUpEmitter = EmitterGenerator.getLevelUpEmitter() {
      map.addChild(levelUpEmitter, position: player.position)
    }
  }
  
  // MARK: - Camera
  private func updateCamera() {
    if (player.position.x > frame.size.width/2 && player.position.x < (map.size.width - frame.size.width/2)) {
      self.cameraNode.position = CGPoint(x: player.position.x - frame.size.width/2, y: cameraNode.position.y);
    }
    if (player.position.y > frame.size.height/2 && player.position.y < (map.size.height - frame.size.height/2)) {
      self.cameraNode.position = CGPoint(x: cameraNode.position.x, y: player.position.y - frame.size.height/2);
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
    playerModel.setActiveSkill(skillName)
  }
}


extension LevelOne: PlayerDelegate {
  func playerDeath() {
    let scene = MainMenu(size: view!.bounds.size)
    
    scene.scaleMode = .ResizeFill
    view!.presentScene(scene, transition: SKTransition.crossFadeWithDuration(1.0))
  }
  
  func playerLeveledUp() {
      levelUpEffects()
      //hud.levelUp(String(playerModel.getLevel()))
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
    
    // uncomment below to readd level up mechanics to game (remember to readd EXP UI too)
    //playerModel.checkIfLeveledUp()
    checkIfBeginNextRound()
    
    hud.updateKillCount(enemiesKilled)
    //hud.updateExperienceFrameFrame(playerModel.getRemainingExpFraction())
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
    playerModel.gainExp(enemiesModel.getExpValue(enemy.name!))
  }
}
