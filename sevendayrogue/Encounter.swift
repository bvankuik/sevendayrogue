//
//  Encounter.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 24/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


extension Encounter {
    enum Direction: UInt32 {
        case north
        case east
        case south
        case west

        static func random() -> Direction {
            let rand = arc4random_uniform(4)
            return Direction(rawValue: rand)!
        }
    }
}

struct Encounter {
    let direction: Direction
    var creatures: [Creature]

    func nextLocation(from current: Location) -> Location {
        let newLocation: Location

        let randomOffset = arc4random_uniform(3)
        let deviation: Int = -1 + Int(randomOffset)

        switch self.direction {
        case .north:
            newLocation = Location(row: current.row - 1, col: current.col + deviation)
        case .east:
            newLocation = Location(row: current.row + deviation, col: current.col + 1)
        case .south:
            newLocation = Location(row: current.row + 1, col: current.col + deviation)
        case .west:
            newLocation = Location(row: current.row + deviation, col: current.col - 1)
        }

        return newLocation
    }

    init(creatures: [Creature]) {
        self.direction = Direction.random()
        self.creatures = creatures
    }
}
