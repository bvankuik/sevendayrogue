//
//  Spell.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 21/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


enum SpellRange {
    case touch
    case range(range: Int)
}

enum SpellLevel: Int {
    case cantrip
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
}

struct Spell {
    var name: String
    var level: SpellLevel
    var price: Int?
    var damageDice: [Die] = []
    var healingDice: [Die] = []
    var acBonus: Int = 0
    var attackBonus: Int = 0
    var damageBonus: Int = 0
    var bonusAttackDice: [Die] = []
    var malusAttackDice: [Die] = []
    var range: SpellRange
    var radius: Int = 0

    init(name: String, level: SpellLevel, range: SpellRange) {
        self.name = name
        self.level = level
        self.range = range
    }
}

func initializeSpells() -> [Spell] {
    var iceBolt = Spell(name: "Ice Bolt",
                        level: SpellLevel.cantrip,
                        range: SpellRange.range(range: 120))
    iceBolt.damageDice = [d10]

    var treatWounds = Spell(name: "Treat Wounds",
                            level: SpellLevel.one,
                            range: SpellRange.touch)
    treatWounds.healingDice = [d8]

    var hurtFlesh = Spell(name: "Hurt Flesh",
                           level: SpellLevel.one,
                           range: SpellRange.touch)
    hurtFlesh.damageDice = [d8]

    var blackness = Spell(name: "Blackness",
                          level: SpellLevel.two,
                          range: SpellRange.range(range: 60))
    blackness.radius = 15
    blackness.attackBonus = -4

    let allSpells = [
        treatWounds,
        hurtFlesh,
        iceBolt,
        blackness
    ]

    return allSpells
}
