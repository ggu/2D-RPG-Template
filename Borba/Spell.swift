//
//  Spell.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class Spell {
  var damage : Int = 0
  var spellName : Spells
  var cost: Double = 0
  
  init(spellDamage: Int, spell : Spells, spellCost: Double)
  {
    damage = spellDamage
    spellName = spell
    cost = spellCost
  }
}
