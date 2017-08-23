//
//  Spell.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 21/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


struct Spell {
    enum Range {
        case touch
        case range(range: Int)
    }

    enum Level: Int {
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
    
    var name: String
    var level: Level
    var price: Int?
    var damageDice: [Die] = []
    var healingDice: [Die] = []
    var acBonus: Int = 0
    var attackBonus: Int = 0
    var damageBonus: Int = 0
    var bonusAttackDice: [Die] = []
    var malusAttackDice: [Die] = []
    var range: Range
    var radius: Int = 0

    init(name: String, level: Level, range: Range) {
        self.name = name
        self.level = level
        self.range = range
    }
}

func allSpells() -> [Spell] {
    var iceBolt = Spell(name: "Ice Bolt",
                        level: Spell.Level.cantrip,
                        range: Spell.Range.range(range: 120))
    iceBolt.damageDice = [d10]

    var treatWounds = Spell(name: "Treat Wounds",
                            level: Spell.Level.one,
                            range: Spell.Range.touch)
    treatWounds.healingDice = [d8]

    var hurtFlesh = Spell(name: "Hurt Flesh",
                           level: Spell.Level.one,
                           range: Spell.Range.touch)
    hurtFlesh.damageDice = [d8]

    var blackness = Spell(name: "Blackness",
                          level: Spell.Level.two,
                          range: Spell.Range.range(range: 60))
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
