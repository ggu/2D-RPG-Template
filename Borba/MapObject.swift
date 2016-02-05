//
//  MapObject.swift
//  Borba
//
//  Created by Gabriel Uribe on 7/25/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

/*
Any map object has:
- 

-obstacles **
** not to be included in playable demo

*/
import SpriteKit

class MapObject : GameObject {
  
  init(map: MapBitMasks) {
    let mapTexture: SKTexture
    switch map {
//    case MapBitMasks.Main:
//      println("main map configuration")
    default:
      mapTexture = AssetManager.sharedInstance.mapTexture
    }
    super.init(texture: mapTexture, color: UIColor.clearColor(), size: mapTexture.size())
    setup()
  }
  
  func setup() {
    anchorPoint = CGPointZero
    zPosition = zPositions.map
    physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
    physicsBody?.categoryBitMask = CategoryBitMasks.Map.rawValue
    lightingBitMask = 1
    //setupLightSource()
  }
  
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
