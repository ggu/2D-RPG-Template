//
//  HUD.swift
//  Borba
//
//  Created by Gabriel Uribe on 1/30/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

class HUD: SKSpriteNode {
  
  let healthFrame: ResourceBar
  let energyFrame: ResourceBar
  let experienceFrame: ExperienceBar
  let levelFrame: LevelBar
  
  init(size: CGSize) {
    healthFrame = ResourceBar(width: size.width, height: size.height, xPosition: 160, color: UIColor(red: 0.164, green: 0.592, blue: 0.286, alpha: 1))
    energyFrame = ResourceBar(width: size.width, height: size.height, xPosition: 400, color: UIColor(red: 0.353, green: 0.659, blue: 0.812, alpha: 1))
    experienceFrame = ExperienceBar(width: size.width, height: size.height)
    levelFrame = LevelBar(width: size.width, height: size.height)
    
    super.init(texture: nil, color: UIColor.clearColor(), size: size)
    
    setup()
  }
  
  func setup() {
    // move this to a class that takes care of the nodes on the UI z index
    addChild(healthFrame)
    addChild(energyFrame)
    addChild(experienceFrame)
    addChild(levelFrame)
  }
  
  func updateEnergyFrame(manaFraction: Double) {
    energyFrame.setMeterScale(manaFraction)
  }
  
  func updateExperienceFrameFrame(expFraction: Double) {
    experienceFrame.setMeterScale(CGFloat(expFraction))
  }
  
  func updateHealthFrame(healthFraction: Double) {
    healthFrame.setMeterScale(healthFraction)
  }
  
  func updateLevelFrame(level: String) {
    levelFrame.setLevel(level)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
