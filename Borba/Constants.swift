//
//  Constants.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import Foundation
import CoreGraphics

typealias JoystickValues = (CGFloat, CGFloat, CGFloat)
typealias SpellString = String
typealias EnemyID = String

enum SoundFile {
  static let Fireball = "FlameSpell.mp3"
  static let ArcaneBolt = "IceSpell.mp3"
  static let LightningStorm = "LightningSpell.mp3"
  static let PlayerDamage = "DamageToPlayer.mp3"
  static let ZombieSpawn = "ZombieSpawn.mp3"
  static let ZombieDeath = "DamageToZombie.mp3"
  static let Music = "music.mp3"
}

enum AnimationKeys {
  static let Damage = "dmg"
  static let Move = "move"
  static let DamageEnemySound = "enemydamagesound"
  static let DamagePlayerSound = "playerdamagesound"
}

enum CategoryBitMasks {
  static let Hero: UInt32 = 1
  static let Enemy: UInt32 = 2
  static let Map: UInt32 = 4
  static let Spell: UInt32 = 8
  static let PenetratingSpell: UInt32 = 16
}

enum zPositions {
  static let Map: CGFloat = 1
  static let MapObjects: CGFloat = 2
  static let Joystick: CGFloat = 3
  static let Thumbstick: CGFloat = 4
  static let UIObjects: CGFloat = 5
  static let UIMenus: CGFloat = 6
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
