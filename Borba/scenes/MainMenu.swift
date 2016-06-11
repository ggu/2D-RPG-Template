//
//  GameScene.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

final class MainMenu: SKScene, SKButtonDelegate {
  var width: CGFloat?
  var height: CGFloat?
  
  override func didMoveToView(view: SKView) {
    setup()
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

  }
  
  override func update(currentTime: CFTimeInterval) {
    
  }
  
  func setup() {
    setupProperties()
    
    setupBackgroud()
    
    setupButtons()
  }
  
  func setupBackgroud() {
    backgroundColor = UIColor.blackColor()
  }
  
  func setupButtons() {
    setupPlayButton()
    
    setupSettingsButton()
    //setupLeaderboardButton()
  }
  
  func setupPlayButton() {
    let playButton = SKButton(color: UIColor.redColor(), text: "Play", tag: SKButton.Tag.mainMenuPlay)
    playButton.position = CGPoint(x: width! / 2, y: height! * 2 / 3)
    playButton.delegate = self
    addChild(playButton)
  }
  
  func setupSettingsButton() {
    let settingsButton = SKButton(color: UIColor.redColor(), text: "Settings", tag: SKButton.Tag.mainMenuSettings)
    settingsButton.position = CGPoint(x: width! / 2, y: height! / 3)
    settingsButton.delegate = self
    addChild(settingsButton)
  }
  
  func setupLeaderboardButton() {
    let sprite = SKSpriteNode(texture: nil, color: UIColor.redColor(), size: CGSize(width: 100, height: 100))
    sprite.position = CGPoint(x: 200, y: 100)
    sprite.zPosition = 2
    addChild(sprite)
  }
  
  func setupProperties() {
    width = scene!.size.width
    height = scene!.size.height
  }
  
  func buttonTapped(tag: SKButton.Tag) {
    switch tag {
    case .mainMenuPlay:
      let scene = LevelOne(size: view!.bounds.size)
      
      scene.scaleMode = .ResizeFill
      view!.presentScene(scene, transition: SKTransition.crossFadeWithDuration(1.0))
    case .mainMenuSettings:
      print("tapped settings button")
    }
  }
  
}
