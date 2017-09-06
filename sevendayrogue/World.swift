//
//  World.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 23/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


extension World {
    struct Grid {
        private var surface: Array<Array<Square>>
        let width: Int
        var height: Int

        func spawnLocation(at edge: Direction) -> Location {
            let location: Location
            switch edge {
            case .north:
                location = Location(x: random(max: self.width), y: 0)
            case .east:
                location = Location(x: self.width - 1, y: random(max: self.height))
            case .south:
                location = Location(x: random(max: self.width), y: self.height - 1)
            case .west:
                location = Location(x: 0, y: random(max: self.height))
            }

            return location
        }

        mutating func square(for location: Location) -> Square {
            return self.surface[location.x][location.y]
        }

        subscript(x: Int, y: Int) -> Square {
            get {
                return self.surface[x][y]
            }
            set {
                self.surface[x][y] = newValue
            }
        }

        init(width: Int, height: Int) {
            self.surface = []
            self.width = width
            self.height = height

            for _ in 0 ..< width {
                var squares: [Square] = []

                for _ in 0 ..< height {
                    squares.append(Square())
                }

                self.surface.append(squares)
            }
        }
    }
}

extension World.Grid {
    struct Square {
        enum Terrain {
            case normal
            case difficult
        }

        var terrain: Terrain = .normal
        var encounters: [Encounter] = []

        mutating func append(encounter: Encounter) {
            self.encounters.append(encounter)
        }
    }
}

struct World {
    var creatures: [Creature]
    let baseLocation: Location
    var grid: Grid

    var epoch = 0
    var spawnChance = 50
    let spawnDie = d100

    // MARK: - Public function6s

    mutating func increment() {
        self.epoch += 1
        if self.spawnDie.roll() <= self.spawnChance {
            let encounter = WorldFactory.makeEncounter()
            let location = self.grid.spawnLocation(at: encounter.direction.opposite())
            dlog("Making encounter at location \(location)")
            self.grid[location.x, location.y].append(encounter: encounter)
        }
    }

    // MARK: - Life cycle

    init() {
        self.grid = Grid(width: 40, height: 30)
        self.baseLocation = Location(x: self.grid.width/2, y: self.grid.height/2)
        self.creatures = []
    }
}
