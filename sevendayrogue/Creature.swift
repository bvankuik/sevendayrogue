//
//  Creature.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 22/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation
import CoreGraphics


struct Creature {
    enum Alignment: String {
        case lawfulGood = "LG"
        case neutralGood = "NG"
        case chaoticGood = "CG"
        case lawfulNeutral = "LN"
        case trueNeutral = "TN"
        case chaoticNeutral = "CN"
        case lawfulEvil = "LE"
        case neutralEvil = "NE"
        case chaoticEvil = "CE"
    }

    enum Race {
        case human
        case elf
        case halfelf
        case dwarf
        case gnome
        case demon
        case monster(name: String)
    }

    var ac: Int {
        let ac = 10 + (armor?.acBonus ?? 0) + (shield?.acBonus ??  0)
        return ac
    }

    var name: String
    var alignment: Alignment = .trueNeutral
    var race: Race
    var xp: Int = 0
    var armor: Armor?
    var shield: Shield?
    var hp: Int
    var currentHP: Int
    var muscle: Muscle
    var agility: Agility
    var fortitude: Fortitude
    var cleverness: Cleverness
    var judgment: Judgment
    var charm: Charm
    var weapons: [Weapon]
    var spells: [Spell]
    var walkingSpeed: Int
    var flyingSpeed: Int
    var vector: CGRect
}
