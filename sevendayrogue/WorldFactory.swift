//
//  WorldFactory.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 02/09/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


extension WorldFactory {
    struct CreatureNames {
        var race: Creature.Race
        var firstNames: [String]
        var lastNames: [String]
    }
}

class WorldFactory {

    static func makeWorld() -> World {
        let world = World()
        return world
    }

    static func makeEncounter() -> Encounter {
        let encounter = Encounter(creatures: [])
        return encounter
    }

    static func makeCreature() -> Creature {
        let allMonsters = GameData.loadMonsters()

        if let creature = allMonsters.randomItem() {
            return creature
        } else {
            fatalError("Monsters could not be loaded")
        }
    }

}
