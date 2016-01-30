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
  var spellName : Spells?
  
  init(spellDamage: Int, spell : Spells)
  {
    damage = spellDamage
    spellName = spell
  }
}