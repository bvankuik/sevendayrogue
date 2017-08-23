//
//  Weapon.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 22/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


struct Weapon {
    enum Properties {
        case twoHanded
        case reach
        case versatile
    }

    enum Ranged {
        case notRanged
        case ranged(range: Int)
    }

    var name: String
    var price: Int?
    var nAttacks = 1
    var properties: Set<Properties> = []
    var damageDice: [Die]
    var attackBonus: Int = 0
    var damageBonus: Int = 0
    var bonusAttackDice: [Die] = []
    var ranged: Ranged = .notRanged

    init(name: String, damageDice: [Die]) {
        self.name = name
        self.damageDice = damageDice
    }
}

func allWeapons() -> [Weapon] {
    let dagger = Weapon(name: "Dagger", damageDice: [d4])
    let shortsword = Weapon(name: "Shortsword", damageDice: [d6])
    let longsword = Weapon(name: "Longsword", damageDice: [d8])

    let allWeapons = [
        dagger,
        shortsword,
        longsword
    ]

    return allWeapons
}
