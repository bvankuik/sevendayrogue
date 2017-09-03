//
//  Armor.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 22/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


struct Armor {
    enum Weight {
        case none
        case light
        case medium
        case heavy
    }

    enum DexBonus {
        case full
        case capped(dexCap: Int)
        case none
    }

    var name: String
    var acBonus: Int
    var weight: Weight
    var dexBonus: DexBonus
}

struct Shield {
    var name: String
    var acBonus: Int
}

class ArmorList {

    static let instance = ArmorList()

    let none = Armor(name: "None", acBonus: 0, weight: .none, dexBonus: .full)
    let leather = Armor(name: "Leather", acBonus: 1, weight: .light, dexBonus: .full)
    let studded = Armor(name: "Studded", acBonus: 2, weight: .light, dexBonus: .full)
    let halfChain = Armor(name: "Half Chain", acBonus: 3, weight: .medium, dexBonus: .capped(dexCap: 2))
    let scale = Armor(name: "Scale mail", acBonus: 4, weight: .medium, dexBonus: .capped(dexCap: 2))
    let halfPlate = Armor(name: "Half plate", acBonus: 5, weight: .medium, dexBonus: .capped(dexCap: 2))
    let chain = Armor(name: "Chain mail", acBonus: 6, weight: .heavy, dexBonus: .none)
    let splint = Armor(name: "Splint", acBonus: 7, weight: .heavy, dexBonus: .none)
    let plate = Armor(name: "Full plate", acBonus: 8, weight: .heavy, dexBonus: .none)

    let allArmor: [Armor]

    func find(by name: String) -> Armor? {
        let result = self.allArmor.filter { $0.name == name }
        return result.first
    }

    func find(by bonus: Int) -> Armor {
        let result = self.allArmor.filter { $0.acBonus == bonus }
        if let first = result.first {
            return first
        } else {
            return self.none
        }
    }

    init() {
        self.allArmor = [
            self.leather,
            self.studded,
            self.halfChain,
            self.scale,
            self.halfPlate,
            self.chain,
            self.splint,
            self.plate
        ]
    }

}

func allShields() -> [Shield] {
    let shield = Shield(name: "Shield", acBonus: 2)

    return [shield]
}
