//
//  PlayerModelExtension.swift
//  Borba
//
//  Created by Gabriel Uribe on 3/6/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

protocol PlayerDelegate {
  func playerDeath()
}

class Player {
  private var spellManager = SpellManager.newGame()
  private var stats = PlayerStats()
  var activeSpell: Spell
  var activeSpellOnCooldown = false
  var delegate: PlayerDelegate?
  var spellList: [String: Spell]
  let sprite = PlayerSprite()
  
  private init() {
    (activeSpell, spellList) = spellManager.getInitialPlayerSpells()
  }
  
  class func newGame() -> Player {
    return Player()
  }
  
  func getNewPlayerPosition(vX: CGFloat, vY: CGFloat, angle: CGFloat, pos: CGPoint) -> CGPoint {
    var dx: CGFloat = 0
    var dy: CGFloat = 0
    
    if (vX > 0 && vY > 0) {
      dx = CGFloat(stats.movementSpeed * sinf(fabs(Float(angle))));
      dy = CGFloat(sqrtf(powf(stats.movementSpeed, 2) - powf(Float(dx), 2)));
    } else if (vX > 0 && vY < 0) {
      dy = -CGFloat(stats.movementSpeed * sinf(fabs(Float(angle) + Float(M_PI/2))));
      dx = CGFloat(sqrtf(powf(stats.movementSpeed, 2) - powf(Float(dy), 2)));
    } else if (vX < 0 && vY < 0) {
      dy = -CGFloat(stats.movementSpeed * sinf(Float(angle) - Float(M_PI/2)));
      dx = -CGFloat(sqrtf(powf(stats.movementSpeed, 2) - powf(Float(dy), 2)));
    } else if (vX < 0 && vY > 0) {
      dx = -CGFloat(stats.movementSpeed * sinf(Float(angle)));
      dy = CGFloat(sqrtf(powf(stats.movementSpeed, 2) - powf(Float(dx), 2)));
    } else if (vX < 0 && vY == 0) {
      dx = -CGFloat(stats.movementSpeed)
    } else if (vX > 0 && vY == 0) {
      dx = CGFloat(stats.movementSpeed)
    } else if (vX == 0 && vY < 0) {
      dy = -CGFloat(stats.movementSpeed)
    } else if (vX == 0 && vY > 0) {
      dy = CGFloat(stats.movementSpeed)
    }
    
    return CGPoint(x: pos.x + dx, y: pos.y + dy);
  }
  
  func setActiveSkill(spellName: String) {
    if let spell = spellList[spellName] {
      activeSpell = spell
    }
  }
  
  func takeDamage(damage: Double) {
    stats.health -= damage
    checkForDeath()
  }
  
  private func checkForDeath() {
    if isDead() {
      delegate?.playerDeath()
    }
  }
  
  func getAttack() -> Double {
    return stats.attack
  }
  
  func isDead() -> Bool {
    return stats.health <= 0
  }
  
  func canUseSpell() -> Bool {
    return !activeSpellOnCooldown && stats.mana > activeSpell.cost
  }
  
  // refactor this
  func handleSpellCast(angle: CGFloat) -> (SKSpriteNode, SKAction) {
    let spell = SpellNode(spell: activeSpell.spellName, angle: angle)
    activeSpellOnCooldown = true
    stats.mana -= activeSpell.cost
    let action = SKAction.sequence([SKAction.waitForDuration(stats.cooldownModifier * activeSpell.cooldown), SKAction.runBlock({
      self.activeSpellOnCooldown = false
    })])
    return (spell, action)
  }
  
  func regenHealth() {
    stats.regenHealth()
  }
  
  func regenMana() {
    stats.regenMana()
  }
  
  func getRemainingManaFraction() -> Double {
    return stats.getRemainingManaFraction()
  }
  
  func getRemainingHealthFraction() -> Double {
    return stats.getRemainingHealthFraction()
  }
  
  func getSpellDamageModifier() -> Double {
    return stats.spellDamageModifier
  }
}
