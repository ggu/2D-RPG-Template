//
//  SpellManager.swift
//  Borba
//
//  Created by Gabriel Uribe on 3/4/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

final class SpellManager {
  private init() {}
  
  class func newGame() -> SpellManager {
    return SpellManager()
  }
  
  func getInitialPlayerSpells() -> (Spell, [String: Spell]) {
    var spellList =  [String: Spell]()
    
    let fireballSpell = Spell(spellDamage: Spell.Damage.fireball, spell: Spell.Name.fireball, spellCost: Spell.Costs.fireball, spellCooldown: Spell.Cooldowns.fireball)
    let arcaneBoltSpell = Spell(spellDamage: Spell.Damage.arcaneBolt, spell: Spell.Name.arcaneBolt, spellCost: Spell.Costs.arcaneBolt, spellCooldown: Spell.Cooldowns.arcaneBolt)
    let lightningSpell = Spell(spellDamage: Spell.Damage.lightningStorm, spell: Spell.Name.lightning, spellCost: Spell.Costs.lightningStorm, spellCooldown: Spell.Cooldowns.lightningStorm)
    
    spellList[Spell.String.fireball] = fireballSpell
    spellList[Spell.String.arcaneBolt] = arcaneBoltSpell
    spellList[Spell.String.lightningBolt] = lightningSpell
    
    return (fireballSpell, spellList)
  }
}
