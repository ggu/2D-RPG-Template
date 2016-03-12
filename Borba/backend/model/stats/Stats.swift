//
//  Stats.swift
//  Borba
//
//  Created by Gabriel Uribe on 3/9/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import Foundation

protocol Stats {
  var health: Double {get set}
  var maxHealth: Double {get set}
  var attack: Double {get set}
  var movementSpeed: Float {get set}
}
