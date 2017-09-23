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
    let emoji = ["👹", "😈", "👽", "⚔️", "🤺", "👻", "💀", "👾", "🤢", "🎃",
        "😺", "💂‍♀️", "🕵️‍♀️", "👸🏻", "👸🏼", "👸🏽", "🤴🏻", "🤴🏽", "🤴🏾", "🐷", "👨🏻‍✈️", "👨🏽‍✈️"]
        .randomItem()! // Some farmers 👨🏻‍🌾👩🏽‍🌾👨🏿‍🌾👩🏾‍🌾
    var tempDestination: Location?

    func nextLocation(from current: Location) -> Location {
        if let destination = self.tempDestination {
            return self.calculateNextLocation(from: current, to: destination)
        } else {
            return self.calculateNextLocation(from: current)
        }
    }

    private func calculateNextLocation(from current: Location) -> Location {
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

    private func calculateNextLocation(from current: Location, to destination: Location) -> Location {
        // Test to see if next step would immediately go to destination

        guard !current.adjacent(to: destination) else {
            return destination
        }

        // Loop and find midpoint until both are 1 or less
        var midX: Int = destination.x - current.x
        var midY: Int = destination.y - current.y
        var midpoint: Location

        repeat {
            midX = Int(round(Double(midX) / 2.0))
            midY = Int(round(Double(midY) / 2.0))
            midpoint = Location(x: current.x + midX, y: current.y + midY)
        } while !midpoint.adjacent(to: current)

        return midpoint
    }

    init(creatures: [Creature]) {
        self.direction = Direction.random()
        self.creatures = creatures
    }
}
