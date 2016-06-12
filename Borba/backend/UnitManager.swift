//
//  UnitManager.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/11/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

protocol UnitManagerDelegate {
  func playerCastSpell(spell: SKSpriteNode)
  func playerDeath()
}

final class UnitManager {
  var player = Player.newGame()
  var delegate: UnitManagerDelegate?
  
  private init() {
    player.delegate = self
  }
  
  class func newGame() -> UnitManager {
    return UnitManager()
  }
  
  func regenPlayerResources() {
    player.regenMana()
    player.regenHealth()
  }
  
  func playerJoysticsUpdate(moveJoystickValues: JoystickValues, skillJoystickValues: JoystickValues) {
    player.sprite.position = player.getNewPlayerPosition(moveJoystickValues.0, vY: moveJoystickValues.1, angle: moveJoystickValues.2, pos: player.sprite.position)
    if (skillJoystickValues.0 == 0 && skillJoystickValues.1 == 0) {
      player.sprite.updateDirection(moveJoystickValues.2)
    } else {
      player.sprite.updateDirection(skillJoystickValues.2)
      if player.canUseSpell() {
        useSpell(skillJoystickValues.0, thumbY: skillJoystickValues.1)
      }
    }
  }
  
  // MARK: - Spells
  private func useSpell(thumbX: CGFloat, thumbY: CGFloat) {
    let spellSprite: SKSpriteNode
    let action: SKAction
    (spellSprite, action) = player.handleSpellCast(player.sprite.zRotation)
    spellSprite.position = player.sprite.position
    player.sprite.runAction(action)
    
    switch player.activeSpell.spellName {
    case .lightning:
      useLinearSpell(spellSprite, missileSpeed: Spell.MissileSpeeds.lightningStorm, thumbX: thumbX, thumbY: thumbY)
    case .fireball:
      useLinearSpell(spellSprite, missileSpeed: Spell.MissileSpeeds.fireball, thumbX: thumbX, thumbY: thumbY)
    case .arcaneBolt:
      useLinearSpell(spellSprite, missileSpeed: Spell.MissileSpeeds.arcaneBolt, thumbX: thumbX, thumbY: thumbY)
    }
    
    delegate?.playerCastSpell(spellSprite)
  }
  
  private func useLinearSpell(spell: SKSpriteNode, missileSpeed: Double, thumbX: CGFloat, thumbY: CGFloat) {
    var sign = 1
    if thumbX < 0 {
      sign = -1
    }
    let angle = getAngle(thumbY, adjacent: thumbX)
    let (dx,dy) = getTriangleLegs(1000, angle: angle, sign: CGFloat(sign))
    
    let arbitraryPointFaraway = CGPoint(x: spell.position.x + dx, y: spell.position.y + dy)
    let duration = getDistance(spell.position, point2: arbitraryPointFaraway) / missileSpeed
    
    let moveAction = SKAction.moveTo(arbitraryPointFaraway, duration: duration)
    let removeAction = SKAction.removeFromParent()
    let completeAction = SKAction.sequence([moveAction, removeAction])
    spell.runAction(completeAction)
  }
}

extension UnitManager: PlayerDelegate {
  func playerDeath() {
    delegate?.playerDeath()
  }
}
