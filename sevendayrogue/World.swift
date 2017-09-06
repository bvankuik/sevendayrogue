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

        // MARK: - Public functions

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

        func square(for location: Location) -> Square {
            return self.surface[location.x][location.y]
        }

        func increment() -> Grid {
            var newGrid = Grid(width: self.width, height: self.height)
            for x in 0 ..< newGrid.width {
                for y in 0 ..< newGrid.height {
                    let square = self[x,y]
                    for encounter in square.encounters {
                        let currentLocation = Location(x: x, y: y)
                        let nextLocation = encounter.nextLocation(from: currentLocation)
                        dlog("Moving encounter from \(currentLocation) to \(nextLocation)")
                        if self.grid(contains: nextLocation) {
                            newGrid[nextLocation.x, nextLocation.y].append(encounter: encounter)
                        }
                    }
                }
            }
            return newGrid
        }

        func grid(contains location: Location) -> Bool {
            if location.x < 0 || location.x >= self.width {
                return false
            }
            if location.y < 0 || location.y >= self.height {
                return false
            }
            return true
        }

        // MARK: - Operators

        subscript(x: Int, y: Int) -> Square {
            get {
                return self.surface[x][y]
            }
            set {
                self.surface[x][y] = newValue
            }
        }

        // MARK: - Life cycle

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

class World {
    private let baseLocation: Location
    private let spawnDie = d100
    private var spawnChance = 50

    private(set) var grid: Grid
    private(set) var epoch = 0

    // MARK: - Public functions

    func increment() {
        self.epoch += 1
        self.grid = self.grid.increment()
        if self.spawnDie.roll() <= self.spawnChance {
            let encounter = WorldFactory.makeEncounter()
            let location = self.grid.spawnLocation(at: encounter.direction.opposite())
            dlog("Making encounter at location \(location)")
            self.grid[location.x, location.y].append(encounter: encounter)
        }
    }

    // MARK: - Life cycle

    init() {
        self.grid = Grid(width: constants.worldGridWidth, height: constants.worldGridHeight)
        self.baseLocation = Location(x: self.grid.width/2, y: self.grid.height/2)
    }
}
