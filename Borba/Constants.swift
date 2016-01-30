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
}

struct MissileSpeeds
{
  static let fireball = 200
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