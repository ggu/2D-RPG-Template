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
    case Demo
    case Main
    case Last
  }
  
  init(map: Level) {
    let mapTexture: SKTexture
    switch map {
    default:
      mapTexture = AssetManager.sharedInstance.mapTexture
    }
    super.init(texture: mapTexture, color: UIColor.clearColor(), size: mapTexture.size())
    setup()
  }
  
  private func setup() {
    anchorPoint = CGPointZero
    lightingBitMask = 1
    physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
    physicsBody?.categoryBitMask = CategoryBitMasks.Map
    zPosition = zPositions.Map
    blendMode = SKBlendMode.Replace
    //setupEmitters()
  }
  
  private func setupEmitters() {
    if let rainParticles = AssetManager.sharedInstance.getEmitter(Particle.Rain) {
      rainParticles.zPosition = zPositions.MapObjects
      rainParticles.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
      rainParticles.particlePositionRange = CGVector(dx: frame.width, dy: frame.height)
      addChild(rainParticles)
    }
    
    if let fireParticles = AssetManager.sharedInstance.getEmitter(Particle.Fire) {
      fireParticles.zPosition = zPositions.MapObjects
      fireParticles.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
      addChild(fireParticles)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
