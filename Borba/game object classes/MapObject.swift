//
//  MapObject.swift
//  Borba
//
//  Created by Gabriel Uribe on 7/25/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class MapObject: GameObject {
  
  enum Level {
    case demo
    case main
    case last
  }
  
  init(map: Level) {
    let mapTexture: SKTexture
    switch map {
    default:
      mapTexture = AssetManager.mapTexture
    }
    super.init(texture: mapTexture, color: UIColor.clearColor(), size: mapTexture.size())
    setup()
  }
  
  private func setup() {
    anchorPoint = CGPointZero
    lightingBitMask = 1
    physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
    physicsBody?.categoryBitMask = CategoryBitMasks.map
    zPosition = zPositions.map
    blendMode = SKBlendMode.Replace
    //setupEmitters()
  }
  
  private func setupEmitters() {
    if let rainParticles = AssetManager.getEmitter(Particle.rain) {
      rainParticles.zPosition = zPositions.mapObjects
      rainParticles.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
      rainParticles.particlePositionRange = CGVector(dx: frame.width, dy: frame.height)
      addChild(rainParticles)
    }
    
    if let fireParticles = AssetManager.getEmitter(Particle.fire) {
      fireParticles.zPosition = zPositions.mapObjects
      fireParticles.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
      addChild(fireParticles)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
