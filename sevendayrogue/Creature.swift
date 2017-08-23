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
    enum Alignment {
        case lawfulGood
        case neutralGood
        case chaoticGood
        case lawfulNeutral
        case trueNeutral
        case chaoticNeutral
        case lawfulEvil
        case neutralEvil
        case chaoticEvil
    }

    enum Race: String {
        case human = "human"
        case elf = "elf"
        case halfelf = "half-elf"
        case dwarf = "dwarf"
        case gnome = "gnome"
        case demon = "demon"
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
