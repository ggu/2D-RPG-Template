//
//  CameraNode.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/8/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

class CameraNode: SKNode {
  func center() {
    let cameraPositionInScene: CGPoint = scene!.convertPoint(position, fromNode: parent!)
    
    let xPos = parent!.position.x - cameraPositionInScene.x
    let yPos = parent!.position.y - cameraPositionInScene.y
    
    parent?.position = CGPoint(x: xPos, y: yPos);
  }
}
