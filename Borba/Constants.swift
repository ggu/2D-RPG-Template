//
//  Constants.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import Foundation
import CoreGraphics
import SpriteKit

typealias JoystickValues = (CGFloat, CGFloat, CGFloat)
typealias SpellString = String
typealias EnemyID = String

enum SoundFile {
  static let fireball = "FlameSpell.mp3"
  static let arcaneBolt = "IceSpell.mp3"
  static let lightningStorm = "LightningSpell.mp3"
  static let playerDamage = "DamageToPlayer.mp3"
  static let zombieSpawn = "ZombieSpawn.mp3"
  static let zombieDeath = "DamageToZombie.mp3"
  static let music = "music.mp3"
}

enum AnimationKeys {
  static let damage = "dmg"
  static let move = "move"
  static let damageEnemySound = "enemydamagesound"
  static let damagePlayerSound = "playerdamagesound"
}

enum CategoryBitMasks {
  static let hero: UInt32 = 1
  static let enemy: UInt32 = 2
  static let map: UInt32 = 4
  static let spell: UInt32 = 8
  static let penetratingSpell: UInt32 = 16
}

enum zPositions {
  static let map: CGFloat = 1
  static let mapObjects: CGFloat = 2
  static let joystick: CGFloat = 3
  static let thumbstick: CGFloat = 4
  static let UIObjects: CGFloat = 5
  static let UIMenus: CGFloat = 6
}

enum Color {
  static let hpBar = UIColor(red: 0.164, green: 0.592, blue: 0.286, alpha: 1)
  static let energyBar = UIColor(red: 0.353, green: 0.659, blue: 0.812, alpha: 1)
  static let resourceFrame = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
}

let PlayerStartingPosition = CGPoint(x: 300, y: 160)

// MARK: - Inline functions
func getRadiansBetweenTwoPoints(firstPoint: CGPoint, secondPoint: CGPoint) -> Double {
  return Double(atan2(secondPoint.y - firstPoint.y, secondPoint.x - firstPoint.x)) + M_PI/2
}

func getRandomNumber(upperLimit: CGFloat) -> CGFloat {
  return CGFloat(arc4random_uniform(UInt32(upperLimit + 1)))
}

func getDistance(point1: CGPoint, point2: CGPoint) -> Double {
  return Double(sqrt(pow((point1.x - point2.x), 2) + pow((point1.y - point2.y), 2)))
}

func getAngle(opposite: CGFloat, adjacent: CGFloat) -> CGFloat {
  return atan(opposite / adjacent)
}

func getTriangleLegs(hypotenuse: CGFloat, angle: CGFloat, sign: CGFloat) -> (CGFloat, CGFloat) {
  let dy = sin(angle) * 1000 * sign
  let dx = cos(angle) * 1000 * sign
  return (dx, dy)
}
