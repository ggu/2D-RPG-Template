//
//  AssetManager.swift
//  Borba
//
//  Created by Gabriel Uribe on 8/10/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class AssetManager {
  static let sharedInstance = AssetManager()
  
  let heroTexture = SKTexture(imageNamed: "hero.png")
  let enemyTexture = SKTexture(imageNamed: "enemy.png")
  let mapTexture = SKTexture(imageNamed: "ice.jpg")
}