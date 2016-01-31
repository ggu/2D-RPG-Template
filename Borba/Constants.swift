//
//  Constants.swift
//  Borba
//
//  Created by Gabriel Uribe on 6/5/15.
//  Copyright (c) 2015 Team Five Three. All rights reserved.
//

import Foundation
import CoreGraphics

enum Spells
{
  case Fireball
  case Frostbolt
  case Lightning
}

struct MissileSpeeds
{
  static let fireball = 200.0
  static let lightning = 400.0
}

struct SpellCosts {
  static let fireball = 8.0
  static let lightning = 6.0
}

struct ExpValues {
  static let enemy = 10.0
}

struct AnimationKeys {
  static let damage = "dmg"
}

struct ImageNames
{
  static let mainMap = "ice"
}

enum CategoryBitMasks: UInt32
{
  case Hero = 1
  case Enemy = 2
  case Map = 4
  case Spell = 8
}

enum MapBitMasks: UInt32
{
  case Demo = 1
  case Main = 2
  case Last = 4
}

struct Button
{
  static let leftMargin: CGFloat = 20
  static let rightMargin: CGFloat = 20
  static let topMargin: CGFloat = 10
  static let bottomMargin: CGFloat = 10
}
enum ButtonType: UInt32 // need to make MainMenu a type of ButtonType
{
  case MainMenuPlay = 1
  case MainMenuSettings = 2
}

struct zPositions
{
  static let map: CGFloat = 1
  static let mapObjects: CGFloat = 2
  static let joystick: CGFloat = 3
  static let thumbstick: CGFloat = 4
  static let UIObjects: CGFloat = 5
  static let UIMenus: CGFloat = 6
}

struct thumbstickValues {
  static let maxAbsX: CGFloat = 70
  static let maxAbsY: CGFloat = 70
}

// MARK: - Inline functions

func getRadiansBetweenTwoPoints(firstPoint: CGPoint, secondPoint: CGPoint) -> Double {
  return Double(atan2(secondPoint.y - firstPoint.y, secondPoint.x - firstPoint.x)) + M_PI/2
}

func getRandomNumber(upperLimit: CGFloat) -> CGFloat
{
  return CGFloat(arc4random_uniform(UInt32(upperLimit + 1)))
}

func getDistance(point1: CGPoint, point2: CGPoint) -> Double {
  return Double(sqrt(pow((point1.x - point2.x), 2) + pow((point1.y - point2.y), 2)))
}


