//
//  GameScene.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene, SKButtonDelegate
{
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
    let playButton = SKButton(color: UIColor.redColor(), text: "Play", type: ButtonType.MainMenuPlay)
    playButton.position = CGPointMake(width! / 2, height! * 2 / 3)
    playButton.delegate = self
    addChild(playButton)
    //print(playButton)
  }
  
  func setupSettingsButton() {
    let settingsButton = SKButton(color: UIColor.redColor(), text: "Settings", type: ButtonType.MainMenuSettings)
    settingsButton.position = CGPointMake(width! / 2, height! / 3)
    settingsButton.delegate = self
    addChild(settingsButton)
    //print(settingsButton)
  }
  
  func setupLeaderboardButton() {
    let sprite = SKSpriteNode(texture: nil, color: UIColor.redColor(), size: CGSizeMake(100, 100))
    sprite.position = CGPointMake(200, 100)
    sprite.zPosition = 2
    addChild(sprite)
    //print(sprite)
  }
  
  func setupProperties() {
    width = scene!.size.width
    height = scene!.size.height
    //print("\(width) and \(height)")
  }
  
  func buttonTapped(type: ButtonType) {
    switch type
    {
    case ButtonType.MainMenuPlay:
      //print("tapped play button")
      let scene = LevelOne(size: view!.bounds.size)
      
      scene.scaleMode = .ResizeFill
      view!.presentScene(scene, transition: SKTransition.crossFadeWithDuration(1.0))
      //view!.presentScene(scene, transition: SKTransition.doorsOpenHorizontalWithDuration(1.0))
      //view!.presentScene(scene, transition: SKTransition.fadeWithDuration(1.0))
      // segue into main level
    case ButtonType.MainMenuSettings:
      print("tapped settings button")
      // segue into settings page
    }
  }
  
}
