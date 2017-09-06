//
//  Encounter.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 24/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


struct Encounter {
    let direction: Direction
    let creatures: [Creature]
    let origin = Direction.random()
    let emoji = ["👹", "😈", "👽", "👻", "💀", "👾", "🤢", "🎃", "😺", "💂‍♀️", "🕵️‍♀️"].randomItem()!

    func nextLocation(from current: Location) -> Location {
        let randomOffset = arc4random_uniform(3)
        let deviation: Int = -1 + Int(randomOffset)
        let nextX: Int
        let nextY: Int

        switch self.direction {
        case .north:
            nextX = current.x + deviation
            nextY = current.y - 1
        case .east:
            nextX = current.x + 1
            nextY = current.y + deviation
        case .south:
            nextX = current.x + deviation
            nextY = current.y + 1
        case .west:
            nextX = current.x - 1
            nextY = current.y + deviation
        }

        let newLocation = Location(x: nextX, y: nextY)
        return newLocation
    }

    init(creatures: [Creature]) {
        self.direction = Direction.random()
        self.creatures = creatures
    }
}
