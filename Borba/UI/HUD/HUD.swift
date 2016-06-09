//
//  HUD.swift
//  Borba
//
//  Created by Gabriel Uribe on 1/30/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

protocol HUDDelegate {
  func skillButtonTouched(skillName: SpellString)
}

class HUD: SKSpriteNode {
  
  let movementJoystick = SKJoystick(color: UIColor.redColor(), size: CGSize(width: 100, height: 100))
  let skillJoystick = SKJoystick(color: UIColor.redColor(), size: CGSize(width: 100, height: 100))
  private let energyFrame: ResourceBar
  private let experienceFrame: ExperienceBar
  private let healthFrame: ResourceBar
  private let killCountLabel = SKLabelNode(text: "Kill Count: 0")
  private let levelFrame: LevelBar
  private let skillBar : SkillBar
  var delegate: HUDDelegate?

  static let MaxResource = 1.0
  
  init(size: CGSize) {
    healthFrame = ResourceBar(width: size.width, height: size.height, xPosition: 160, color: Color.hpBar)
    energyFrame = ResourceBar(width: size.width, height: size.height, xPosition: 400, color: Color.energyBar)
    experienceFrame = ExperienceBar(width: size.width, height: size.height)
    levelFrame = LevelBar(width: size.width, height: size.height)
    skillBar = SkillBar(color: UIColor.clearColor(), size: CGSize(width: 40, height: 120))
    
    super.init(texture: nil, color: UIColor.clearColor(), size: size)
    
    setup()
  }
  
  func levelUp(playerLevel: String) {
    updateHealthFrame(HUD.MaxResource)
    updateEnergyFrame(HUD.MaxResource)
    updateLevelFrame(playerLevel)
  }
  
  private func setup() {
    zPosition = zPositions.UIObjects
    
    addChild(healthFrame)
    addChild(energyFrame)
    //addChild(experienceFrame)
    //addChild(levelFrame)
    setupKillCountLabel()
    setupJoysticks()
    setupSkillBar()
  }
  
  private func setupSkillBar() {
    skillBar.position = CGPoint(x: size.width - 20, y: size.height - 70)
    skillBar.zPosition = zPositions.UIObjects
    skillBar.delegate = self
    addChild(skillBar)
  }
  
  private func setupJoysticks() {
    movementJoystick.position = CGPoint(x: 100, y: 100)
    addChild(movementJoystick)
    
    skillJoystick.position = CGPoint(x: size.width - 100, y: 100)
    addChild(skillJoystick)
  }
  
  func getJoystickValues() -> (JoystickValues, JoystickValues) {
    let movementJoystickValues = (movementJoystick.thumbX, movementJoystick.thumbY, movementJoystick.angle)
    let skillJoystickValues = (skillJoystick.thumbX, skillJoystick.thumbY, skillJoystick.angle)
    return (movementJoystickValues, skillJoystickValues)
  }
  
  func updateKillCount(count: Int) {
    let show = SKAction.fadeInWithDuration(0.5)
    //let wait = SKAction.waitForDuration(2.0)
    let hide = SKAction.fadeOutWithDuration(3.0)
    killCountLabel.runAction(SKAction.sequence([show, hide]))
    killCountLabel.text = "Kill Count: " + String(count)
  }
  
  func setupKillCountLabel() {
    killCountLabel.fontSize = 16
    killCountLabel.fontName = "Copperplate"
    killCountLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
    killCountLabel.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - 40)
    killCountLabel.zPosition = zPositions.UIObjects
    killCountLabel.alpha = 0
    addChild(killCountLabel)
  }
  
  func updateEnergyFrame(manaFraction: Double) {
    energyFrame.setMeterScaleAnimated(CGFloat(manaFraction))
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

extension HUD: SkillBarDelegate {
  func skillButtonTouched(skillName: SpellString) {
    delegate?.skillButtonTouched(skillName)
  }
}
