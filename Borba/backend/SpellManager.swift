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
    
    let fireballSpell = Spell(spellDamage: Spell.Damage.Fireball, spell: Spell.Name.Fireball, spellCost: Spell.Costs.Fireball, spellCooldown: Spell.Cooldowns.Fireball)
    let arcaneBoltSpell = Spell(spellDamage: Spell.Damage.ArcaneBolt, spell: Spell.Name.ArcaneBolt, spellCost: Spell.Costs.ArcaneBolt, spellCooldown: Spell.Cooldowns.ArcaneBolt)
    let lightningSpell = Spell(spellDamage: Spell.Damage.LightningStorm, spell: Spell.Name.Lightning, spellCost: Spell.Costs.LightningStorm, spellCooldown: Spell.Cooldowns.LightningStorm)
    
    spellList[Spell.String.Fireball] = fireballSpell
    spellList[Spell.String.ArcaneBolt] = arcaneBoltSpell
    spellList[Spell.String.LightningBolt] = lightningSpell
    
    return (fireballSpell, spellList)
  }
}
