//
//  File.swift
//  Borba
//
//  Created by Gabriel Uribe on 7/25/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

/*
Any game object has:
- an image
- size
*/
class GameObject: SKSpriteNode
{
  override init(texture: SKTexture?, color: UIColor, size: CGSize)
  {
    super.init(texture: texture, color: color, size: size)
  }

  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
  }
}