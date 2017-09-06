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

    func nextLocation(from current: Location) -> Location {
        let newLocation: Location

        let randomOffset = arc4random_uniform(3)
        let deviation: Int = -1 + Int(randomOffset)

        switch self.direction {
        case .north:
            newLocation = Location(x: current.x - 1, y: current.y + deviation)
        case .east:
            newLocation = Location(x: current.x + deviation, y: current.y + 1)
        case .south:
            newLocation = Location(x: current.x + 1, y: current.y + deviation)
        case .west:
            newLocation = Location(x: current.x + deviation, y: current.y - 1)
        }

        return newLocation
    }

    init(creatures: [Creature]) {
        self.direction = Direction.random()
        self.creatures = creatures
    }
}
