//
//  GameData.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 23/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation
import CoreGraphics


class GameData {

    static func loadMonsters() -> [Creature] {
        let monsterFileWithHeader = readFile(filename: "monsters.csv")
        let monsterFile = monsterFileWithHeader[1 ..< monsterFileWithHeader.count]

        var monsters: [Creature] = []

        for line in monsterFile {
            let cols = line.components(separatedBy: ";")
            let hpDie = Die(string: cols[6])
            var weapon = WeaponList.instance.find(by: cols[13])
            if let attackBonus = Int(cols[14]) {
                weapon?.attackBonus = attackBonus
            }
            if let die = Die(string: cols[15]) {
                weapon?.damageDice = [die]
            }
            let armor = ArmorList.instance.find(by: Int(cols[4]) ?? 0)

            let creature = Creature(
                name: cols[0],
                alignment: Creature.Alignment(rawValue: cols[1]) ?? .trueNeutral,
                race: Creature.Race.monster(name: cols[2]),
                xp: Int(cols[3]) ?? 0,
                armor: armor,
                shield: nil,
                hp: hpDie?.roll() ?? 0,
                currentHP: hpDie?.max ?? 0,
                muscle: Muscle(score: Int(cols[7]) ?? 10),
                agility: Agility(score: Int(cols[8]) ?? 10),
                fortitude: Fortitude(score: Int(cols[9]) ?? 10),
                cleverness: Cleverness(score: Int(cols[10]) ?? 10),
                judgment: Judgment(score: Int(cols[11]) ?? 10),
                charm: Charm(score: Int(cols[10]) ?? 10),
                weapons: [],
                spells: [],
                walkingSpeed: Int(cols[13]) ?? 30,
                flyingSpeed: Int(cols[14]) ?? 0,
                vector: CGRect()
            )
            monsters.append(creature)
        }
        return monsters
    }

}
