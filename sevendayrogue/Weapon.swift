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

class WeaponList {

    static let instance = WeaponList()

    let dagger = Weapon(name: "Dagger", damageDice: [d4])
    let shortsword = Weapon(name: "Shortsword", damageDice: [d6])
    let longsword = Weapon(name: "Longsword", damageDice: [d8])
    let greataxe = Weapon(name: "Greataxe", damageDice: [d12])

    let allWeapons: [Weapon]

    func find(by name: String) -> Weapon? {
        let result = self.allWeapons.filter { $0.name == name }
        return result.first
    }

    init() {
        self.allWeapons = [
            dagger,
            shortsword,
            longsword
        ]
    }
}

