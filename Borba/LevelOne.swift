//
//  LevelOne.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/22/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

/*
==== to be refactored after playable demo/alpha once procedural content is ready to be generated
*/

import SpriteKit
class LevelOne: SKScene, SKPhysicsContactDelegate, SkillBarDelegate
{ // rename to .. ? Level? as LevelOne sounds hardcoded, should be procedural
  
  // MARK: Properties
  var width: CGFloat?
  var height: CGFloat?
  var player = Player(texture: AssetManager.sharedInstance.heroTexture)
  let cameraNode = SKNode()
  let movementJoystick = SKJoystick(color: UIColor.redColor(), size: CGSizeMake(100, 100))
  let skillJoystick = SKJoystick(color: UIColor.redColor(), size: CGSizeMake(100, 100))
  //let map = MapObject(map: MapBitMasks.Demo)
  let map = MapObject(map: MapBitMasks.Demo)
  let hud: HUD
  var enemies: [Enemy] = []
  var numEnemies = 5
  var playerEnemyInContact = false
  var enemiesInContact: [Enemy] = []
  let killCountLabel = SKLabelNode(text: "Kill Count: 0")
  var enemiesKilled = 0
  var skillBar : SkillBar
  
  override init(size: CGSize) {
    hud = HUD(size: size)
    skillBar = SkillBar(color: UIColor.blueColor(), size: CGSizeMake(30, 100))
    super.init(size: size)
  }
  
  // MARK: Setup functions
  override func didMoveToView(view: SKView) {
    setup()
  }
  
  func setup() {
    view?.multipleTouchEnabled = true
    print("round one - map one - wave one - start")
    physicsWorld.contactDelegate = self
    
    setupProperties()
    setupMap()
    setupHUD()
    setupPlayer()
    runAction(SKAction.repeatActionForever(SKAction.playSoundFileNamed("music.mp3", waitForCompletion: true)))
    setupCamera()
    setupJoysticks()
    setupKillCountLabel()
    setupSkillBar()
    loadEnemies(numEnemies)
  }
  
  
  
  func loadEnemies(numEnemies: Int) {
    let enemies = EnemyGenerator.sharedInstance.generateEnemies(numEnemies)
    spawnEnemies(enemies)
  }
  
  func setupHUD() {
    hud.zPosition = zPositions.UIObjects
    addChild(hud)
  }
  
  func setupMap() {
    self.addChild(map)
    
    if let myParticlePath = NSBundle.mainBundle().pathForResource("Rain", ofType: "sks") {
      let rainParticles = NSKeyedUnarchiver.unarchiveObjectWithFile(myParticlePath) as! SKEmitterNode
      rainParticles.zPosition = zPositions.mapObjects
      rainParticles.position = CGPointMake(map.frame.width / 2, map.frame.height / 2)
      rainParticles.particlePositionRange = CGVectorMake(map.frame.width, map.frame.height)
      map.addChild(rainParticles)
    }
    if let myParticlePath = NSBundle.mainBundle().pathForResource("Fire", ofType: "sks") {
      let fireParticles = NSKeyedUnarchiver.unarchiveObjectWithFile(myParticlePath) as! SKEmitterNode
      fireParticles.zPosition = zPositions.mapObjects
      fireParticles.position = CGPointMake(map.frame.width / 2, map.frame.height / 2)
      map.addChild(fireParticles)
    }
  }
  
  func setupProperties() {
    width = scene!.size.width
    height = scene!.size.height
    print("\(width) and \(height)")
  }
  
  func setupPlayer() {
    map.addChild(player)
  }
  
  func setupCamera() {
    cameraNode.name = "camera"
    map.addChild(cameraNode)
  }
  
  func setupJoysticks() {
    movementJoystick.position = CGPointMake(100, 100)
    addChild(movementJoystick)
    
    skillJoystick.position = CGPointMake(self.width! - 100, 100)
    addChild(skillJoystick)
  }
  
  // MARK: Touch functions
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
  {
//    for touch in (touches ) {
//      let location = touch.locationInNode(self)
//      
//    }
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
    
    hud.updateHealthFrame(player.health / player.maxHealth)
    print("damaged the enemy")
  }
  
  func didEndContact(contact: SKPhysicsContact) {
    if contact.bodyA.categoryBitMask == CategoryBitMasks.Hero.rawValue {
      if let enemy = contact.bodyB.node as? Enemy {
        enemy.inContactWithPlayer = false
        if !enemiesAreInContact() {
          playerEnemyInContact = false
        }
      }
    } else if contact.bodyB.categoryBitMask == CategoryBitMasks.Hero.rawValue {
      if let enemy = contact.bodyA.node as? Enemy {
        enemy.inContactWithPlayer = false
        removeEnemyFromEnemiesInContact(enemy)
        
        if !enemiesAreInContact() {
          playerEnemyInContact = false
        }
      }
    }
  }
  
  func handleGameObjectContact(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
    if bodyA.categoryBitMask == CategoryBitMasks.Hero.rawValue {
      if let enemy = bodyB.node as? Enemy {
        handlePlayerAndEnemyContact(enemy)
      }
    } else if bodyB.categoryBitMask == CategoryBitMasks.Hero.rawValue {
      if let enemy = bodyA.node as? Enemy {
        handlePlayerAndEnemyContact(enemy)
      }
    } else if bodyA.categoryBitMask == CategoryBitMasks.Spell.rawValue {
      bodyA.node?.removeFromParent()
      if let enemy = bodyB.node as? Enemy {
        handlePlayerAndSpellContact(enemy)
      }
    } else if bodyB.categoryBitMask == CategoryBitMasks.Spell.rawValue {
      bodyB.node?.removeFromParent()
      if let enemy = bodyA.node as? Enemy {
        handlePlayerAndSpellContact(enemy)
      }
    } else if bodyA.categoryBitMask == CategoryBitMasks.PenetratingSpell.rawValue {
      if let enemy = bodyB.node as? Enemy {
        handlePlayerAndSpellContact(enemy)
      }
    } else if bodyB.categoryBitMask == CategoryBitMasks.PenetratingSpell.rawValue {
      if let enemy = bodyA.node as? Enemy {
        handlePlayerAndSpellContact(enemy)
      }
    }
  }
  
  // UI buttons
  func buttonTapped(type: ButtonType)
  {
    /* this should contain the first layer of buttons available on the screen (e.g. 'Menu', 'Attack'), which all lead to separate views that are managed independently of this function */
    switch type
    {
    case ButtonType.MainMenuPlay:
      print("tapped play button")
      // segue into main level
    case ButtonType.MainMenuSettings:
      print("tapped settings button")
      // segue into settings page
      //    default:
      //      print("tapped untagged button")
    }
  }
  
  // MARK: - Player and Enemy High Level Logic
  
  func updateEnemies() {
    for enemy in enemies {
      enemy.handleSpriteMovement(player.position)
    }
  }
  
  func updatePlayerState() {
    regenPlayerResources()
    
    player.handleSpriteMovement(movementJoystick.thumbX, vY: movementJoystick.thumbY, angle: movementJoystick.angle)
    if (skillJoystick.thumbX == 0 && skillJoystick.thumbY == 0) {
      player.changeDirection(movementJoystick.angle)
    } else {
      player.changeDirection(skillJoystick.angle)
      if player.canUseSpell() {
        useSpell()
      }
    }
    hud.updateEnergyFrame(player.mana / player.maxMana)
    hud.updateHealthFrame(player.health / player.maxHealth)
  }
  
  func updatePlayerEnemyConditions() {
    if playerEnemyInContact {
      for enemy in enemiesInContact {
        colorizeDamagePlayer()
        colorizeDamageEnemy(enemy)
        damagePlayerAndEnemy(enemy)
      }
    }
  }
  
  func spawnEnemies(var enemies: [Enemy]) {
    if enemies.count >= 1 {
      let spawnAction = SKAction.runBlock({
        let xpos = getRandomNumber(self.map.size.width)
        let ypos = getRandomNumber(self.map.size.height)
        if let enemy = enemies.popLast() {
          enemy.zPosition = zPositions.mapObjects
          enemy.position = CGPointMake(xpos, ypos)
          self.enemies.append(enemy)
          self.map.addChild(enemy)
        }
      })
      let waitAction = SKAction.waitForDuration(Double(getRandomNumber(100) / 50))
      let spawnMoreAction = SKAction.runBlock({
        self.spawnEnemies(enemies)
      })
      
      let sequence = SKAction.sequence([spawnAction, waitAction, spawnMoreAction])
      runAction(sequence)
    }
  }
  
  func handlePlayerAndSpellContact(enemy: Enemy) {
    enemy.health -= player.activeSpell.damage * player.spellDamageModifier
    if (enemy.actionForKey(AnimationKeys.damage) == nil) {
      colorizeDamageEnemy(enemy)
    }
    
    checkForEnemyDeath(enemy)
  }
  
  func handlePlayerAndEnemyContact(enemy: Enemy) {
    damagePlayerAndEnemy(enemy)
    putEnemyInContact(enemy)
  }
  
  func putEnemyInContact(enemy: Enemy) {
    if !enemiesInContact.contains(enemy) {
      enemiesInContact.append(enemy)
    }
    enemy.inContactWithPlayer = true
    playerEnemyInContact = true
  }
  
  
  // MARK: - Player and Enemy Death Helpers
  
  func removeEnemyFromEnemiesInContact(enemy: Enemy) {
    if enemiesInContact.contains(enemy) {
      if let index = enemiesInContact.indexOf(enemy) {
        enemiesInContact.removeAtIndex(index)
        if enemiesInContact.isEmpty {
          playerEnemyInContact = false
          let colorize = SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1, duration: 0.5)
          player.runAction(colorize)
        }
      }
    }
  }
  
  func animateDeath(position: CGPoint) {
    if let myParticlePath = NSBundle.mainBundle().pathForResource("Death", ofType: "sks") {
      let fireParticles = NSKeyedUnarchiver.unarchiveObjectWithFile(myParticlePath) as! SKEmitterNode
      fireParticles.zPosition = zPositions.mapObjects
      fireParticles.position = position
      map.addChild(fireParticles)
      
      let waitAction = SKAction.waitForDuration(1)
      let stopAction = SKAction.runBlock({
        fireParticles.particleBirthRate = 0
      })
      let wait2Action = SKAction.waitForDuration(3)
      let removeAction = SKAction.removeFromParent()
      fireParticles.runAction(SKAction.sequence([waitAction, stopAction, wait2Action, removeAction]))
    }
  }
  
  func enemyDeath(enemy: Enemy) {
    runAction(SKAction.playSoundFileNamed(SoundFiles.zombieDeath, waitForCompletion: false))

    enemiesKilled += 1
    killCountLabel.text = "Kill Count: " + String(enemiesKilled)
    animateDeath(enemy.position)
    
    removeEnemyFromEnemiesInContact(enemy)
    
    if let index = enemies.indexOf(enemy) {
      enemies.removeAtIndex(index)
    }
    
    enemy.removeFromParent()
    player.exp += enemy.expValue
    if player.exp >= player.expToLevel {
      if let myParticlePath = NSBundle.mainBundle().pathForResource("LevelUp", ofType: "sks") {
        let fireParticles = NSKeyedUnarchiver.unarchiveObjectWithFile(myParticlePath) as! SKEmitterNode
        fireParticles.zPosition = zPositions.mapObjects
        fireParticles.position = player.position
        map.addChild(fireParticles)
        
        let waitAction = SKAction.waitForDuration(1)
        let stopAction = SKAction.runBlock({
          fireParticles.particleBirthRate = 0
        })
        let wait2Action = SKAction.waitForDuration(3)
        let removeAction = SKAction.removeFromParent()
        fireParticles.runAction(SKAction.sequence([waitAction, stopAction, wait2Action, removeAction]))
      }
      player.levelUp()
      hud.updateHealthFrame(1)
      hud.updateEnergyFrame(1)
      hud.updateLevelFrame(String(player.level))
    }
    
    if enemies.isEmpty {
      let waitAction = SKAction.waitForDuration(4)
      let spawnAction = SKAction.runBlock({
        self.numEnemies += 5
        self.loadEnemies(self.numEnemies)
      })
      
      let sequence = SKAction.sequence([waitAction, spawnAction])
      runAction(sequence)
    }
    hud.updateExperienceFrameFrame(player.exp / player.expToLevel)
  }
  
  func playerDeath() {
    let scene = MainMenu(size: view!.bounds.size)
    
    scene.scaleMode = .ResizeFill
    view!.presentScene(scene, transition: SKTransition.crossFadeWithDuration(1.0))
  }
  
  // MARK: - Spells
  
  func useSpell() {
    let spellSprite = player.handlePlayerSpellCast()
    spellSprite.position = player.position
    
    switch player.activeSpell.spellName {
    case .Lightning:
      useLightning(spellSprite)
    case .Fireball:
      useFireball(spellSprite)
    case .Frostbolt:
      useFrostbolt(spellSprite)
    }
    map.addChild(spellSprite)
  }
  
  func useLightning(lightning: SKSpriteNode) {
    let dx = skillJoystick.thumbX * 100
    let dy = skillJoystick.thumbY * 100
    let arbitraryPointFaraway = CGPointMake(lightning.position.x + skillJoystick.thumbX * 100, lightning.position.y + skillJoystick.thumbY * 100)
    let duration = getDistance(lightning.position, point2: arbitraryPointFaraway) / MissileSpeeds.lightning
    
    let moveAction = SKAction.moveByX(dx, y: dy, duration: duration)
    let removeAction = SKAction.removeFromParent()
    let completeAction = SKAction.sequence([moveAction, removeAction])
    lightning.runAction(completeAction)
  }
  
  func useFrostbolt(frostbolt: SKSpriteNode) {
    let dx = skillJoystick.thumbX * 100
    let dy = skillJoystick.thumbY * 100
    let arbitraryPointFaraway = CGPointMake(frostbolt.position.x + skillJoystick.thumbX * 100, frostbolt.position.y + skillJoystick.thumbY * 100)
    let duration = getDistance(frostbolt.position, point2: arbitraryPointFaraway) / MissileSpeeds.frostbolt
    
    let moveAction = SKAction.moveByX(dx, y: dy, duration: duration)
    let removeAction = SKAction.removeFromParent()
    let completeAction = SKAction.sequence([moveAction, removeAction])
    frostbolt.runAction(completeAction)
  }
  
  func useFireball(fireball: SKSpriteNode) {
    let dx = skillJoystick.thumbX * 100
    let dy = skillJoystick.thumbY * 100
    let arbitraryPointFaraway = CGPointMake(fireball.position.x + skillJoystick.thumbX * 100, fireball.position.y + skillJoystick.thumbY * 100)
    let duration = getDistance(fireball.position, point2: arbitraryPointFaraway) / MissileSpeeds.fireball
    
    let moveAction = SKAction.moveByX(dx, y: dy, duration: duration)
    let removeAction = SKAction.removeFromParent()
    let completeAction = SKAction.sequence([moveAction, removeAction])
    fireball.runAction(completeAction)
  }
  
  // MARK: - Low level calculations/helpers
  
  func regenPlayerResources() {
    regenMana()
    regenHealth()
  }
  
  func regenMana() {
    if player.mana < player.maxMana {
      player.mana += player.manaRegenRate
    }
  }
  
  func regenHealth() {
    if player.health < player.maxHealth {
      player.health += player.hpRegenRate
    }
  }
  
  func enemiesAreInContact() -> Bool {
    return !enemiesInContact.isEmpty
  }
  
  // MARK: Player and Enemy damage
  
  func damagePlayerAndEnemy(enemy: Enemy) {
    damagePlayer(enemy.attack)
    damageEnemy(enemy, damage: player.attack)
  }
  
  func damagePlayer(damage: Double) {
//    if player.actionForKey(AnimationKeys.damagePlayerSound) == nil {
//      let action = SKAction.playSoundFileNamed(SoundFiles.playerDamage, waitForCompletion: false)
//      player.runAction(action, withKey: AnimationKeys.damagePlayerSound)
//    }

    player.health -= damage
    checkForPlayerDeath()
  }
  
  func damageEnemy(enemy: Enemy, damage: Double) {
//    let soundAction = enemy.actionForKey(AnimationKeys.damageEnemySound)
//    if (soundAction == nil) {
//      let action = SKAction.playSoundFileNamed(SoundFiles.zombieSpawn, waitForCompletion: true)
//      enemy.runAction(action, withKey: AnimationKeys.damageEnemySound)
//    }

    enemy.health -= damage
    
    if isEnemyDead(enemy) {
      enemyDeath(enemy)
    }
  }
  
  //MARK: Player and Enemy Death
  
  func checkForPlayerDeath() {
    if isPlayerDead() {
      playerDeath()
    }
  }
  
  func checkForEnemyDeath(enemy: Enemy) {
    if isEnemyDead(enemy) {
      enemyDeath(enemy)
    }
  }
  
  func isEnemyDead(enemy: Enemy) -> Bool {
    return enemy.health <= 0
  }
  
  func isPlayerDead() -> Bool {
    return player.health <= 0
  }
  
  // MARK: Delegate
  
  func skillButtonTouched(skillName: Spells) {
    player.setActiveSkill(skillName)
  }
  
  // MARK: - Player and Enemy Visuals
  
  
  func setupSkillBar() {
    //skillBar.skills = player.spellList
    skillBar.position = CGPointMake(width! - 20, height! - 70)
    skillBar.zPosition = zPositions.UIObjects
    skillBar.delegate = self
    addChild(skillBar)
  }
  
  func setupKillCountLabel() {
    killCountLabel.fontSize = 16
    killCountLabel.fontName = "Copperplate"
    killCountLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
    killCountLabel.position = CGPointMake(width!/2, height! - 40)
    killCountLabel.zPosition = zPositions.UIObjects
    addChild(killCountLabel)
  }
  
  func colorizeDamagePlayer() {
    if !player.hasActions() {
      let colorize = SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1, duration: 0.5)
      let colorizeBack = SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1, duration: 0.5)
      player.runAction(SKAction.sequence([colorize, colorizeBack]), withKey: AnimationKeys.damage)
    }
  }
  
  func colorizeDamageEnemy(enemy: Enemy) {
    if (enemy.actionForKey(AnimationKeys.damage) == nil) {
      let colorize = SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1, duration: 0.5)
      let colorizeBack = SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1, duration: 0.5)
      enemy.runAction(SKAction.sequence([colorize, colorizeBack]), withKey: AnimationKeys.damage)
    }
  }
  
  // MARK: - Camera
  func updateCamera() {
    if (player.position.x > frame.size.width/2 && player.position.x < (map.size.width - frame.size.width/2))
    {
      self.cameraNode.position = CGPointMake(player.position.x - frame.size.width/2, cameraNode.position.y);
    }
    if (player.position.y > frame.size.height/2 && player.position.y < (map.size.height - frame.size.height/2))
    {
      self.cameraNode.position = CGPointMake(cameraNode.position.x, player.position.y - frame.size.height/2);
    }
    
    centerOnNode(cameraNode)
  }
  
  func centerOnNode(node: SKNode)
  {
    let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: node.parent!)
    
    let xPos = node.parent!.position.x - cameraPositionInScene.x
    let yPos = node.parent!.position.y - cameraPositionInScene.y
    
    node.parent?.position = CGPointMake(xPos, yPos);
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
