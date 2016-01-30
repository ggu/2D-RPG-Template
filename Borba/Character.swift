//
//  Character.swift
//  Borba
//
//  Created by Gabriel Uribe on 7/25/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

/* 
Any character (enemy or player) has:
- health
- attack
- defense
- movement speed
- items (not in playable demo)
*/

import SpriteKit

class Character : GameObject
{
  var health : Int = 0
  var attack : Int = 0
  var defense : Int = 0
  var movementSpeed : Float = 0
  //var items : NSMutableDictionary
  
  override init(texture: SKTexture?, color: UIColor, size: CGSize)
  {
    super.init(texture: texture, color: color, size: size)
  }
  

  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
  }
}
