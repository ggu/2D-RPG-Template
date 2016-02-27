//
//  SKNodeExtension.swift
//  Borba
//
//  Created by Gabriel Uribe on 3/9/16.
//  Copyright © 2016 Team Five Three. All rights reserved.
//

import SpriteKit

extension SKNode {
  func addChild(node: SKNode, position: CGPoint) {
    node.position = position
    addChild(node)
  }
}
