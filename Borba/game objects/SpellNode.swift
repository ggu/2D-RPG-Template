//
//  SpellNode.swift
//  Borba
//
//  Created by Gabriel Uribe on 1/30/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

class SpellNode: Sprite {
  private enum Size {
    static let fireball = CGSize(width: 30, height: 30)
    static let arcaneBolt = CGSize(width: 20, height: 20)
    static let lightningStorm = CGSize(width: 60, height: 60)
  }

  private let spellName: Spell.Name
  
  init(spell: Spell.Name, angle: CGFloat) {
    spellName = spell
    
    let spellSize: CGSize
    let soundFileName: String
    switch spellName {
    case .fireball:
      spellSize = Size.fireball
      soundFileName = SoundFile.fireball
    case .arcaneBolt:
      spellSize = Size.arcaneBolt
      soundFileName = SoundFile.arcaneBolt
    case .lightning:
      spellSize = Size.lightningStorm
      soundFileName = SoundFile.lightningStorm
    }
    
    super.init(texture: nil, color: UIColor.clearColor(), size: spellSize)
    
    setup(angle)
    playSound(soundFileName)
  }
  
  func fizzleOut() {
    removeAllActions()
    let scaleTo = SKAction.scaleYTo(0.3, duration: 0.3)
    let fadeOut = SKAction.fadeOutWithDuration(0.3)
    physicsBody = nil
    runAction(SKAction.group([fadeOut, scaleTo]))
  }
  
  private func setup(angle: CGFloat) {
    setupEmitter()
    setupDefaultPhysics(angle)
    
    switch spellName {
    case .lightning:
      physicsBody?.categoryBitMask = CategoryBitMasks.penetratingSpell
      break
    default:
      break
    }
  }
  
  private func setupEmitter() {
    if let emitter = AssetManager.getSpellEmitter(spellName) {
      emitter.zPosition = zPositions.mapObjects
      emitter.position = CGPointZero
      addChild(emitter)
    }
  }
  
  private func setupDefaultPhysics(angle: CGFloat) {
    zRotation = angle + CGFloat(M_PI)
    physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width, height: size.height))
    physicsBody?.collisionBitMask = 0
    physicsBody?.categoryBitMask = CategoryBitMasks.spell
    physicsBody?.contactTestBitMask = CategoryBitMasks.enemy
    physicsBody?.affectedByGravity = false
    physicsBody?.dynamic = false
  }
  
  private func playSound(soundFileName: String) {
    runAction(SKAction.playSoundFileNamed(soundFileName, waitForCompletion: false))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
