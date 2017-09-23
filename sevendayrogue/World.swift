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
        let baseLocation: Location

        // MARK: - Public functions

        func encounters(in area: Area) -> [Encounter] {
            var allEncounters: [Encounter] = []

            for x in 0 ..< self.width {
                for y in 0 ..< self.height {
                    let encounters = self[x,y].encounters
                    if !encounters.isEmpty {
                        let location = Location(x: x, y: y)
                        if area.contains(location: location) {
                            allEncounters.append(contentsOf: encounters)
                        }
                    }
                }
            }
            return allEncounters
        }

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

        func nEncounters() -> Int {
            var nEncounters = 0
            for x in 0 ..< self.width {
                for y in 0 ..< self.height {
                    nEncounters += self[x,y].encounters.count
                }
            }
            return nEncounters
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
            self.baseLocation = Location(x: width/2, y: height/2)
            self.surface = []
            self.width = width
            self.height = height

            for x in 0 ..< width {
                var squares: [Square] = []

                for y in 0 ..< height {
                    let currentLocation = Location(x: x, y: y)
                    let isBase = (currentLocation == baseLocation)
                    squares.append(Square(encounters: [], isBase: isBase))
                }

                self.surface.append(squares)
            }
        }
    }
}

extension World.Grid {
    struct Square {
        var encounters: [Encounter] = []
        var isBase: Bool

        mutating func append(encounter: Encounter) {
            self.encounters.append(encounter)
        }
    }
}

class World {
    private let spawnDie = d100

    private(set) var grid: Grid
    private(set) var epoch = 0
    private var actions: [Actionable] = []

    var isSpawning = true

    // MARK: - Public functions

    func append(newAction: Actionable) {
        self.actions.append(newAction)
    }

    func increment() {
        self.epoch += 1
        let spawnChance = self.spawnChance()
        if self.isSpawning && self.spawnDie.roll() <= spawnChance {
            let encounter = WorldFactory.makeEncounter()
            let location = self.grid.spawnLocation(at: encounter.direction.opposite())
            dlog("Making encounter at location \(location)")
            self.grid[location.x, location.y].append(encounter: encounter)
        }

        for var action in self.actions {
            if let hailAction = action as? HailAction {
                dlog("Hailing")
                let hailArea = Area(origin: self.grid.baseLocation, radius: hailAction.radius)
//                self.grid.encounters(in: hailArea)[0].tempDestination = self.grid.baseLocation
            }
            action.increment()
        }
        self.actions = self.actions.filter { $0.remainingRounds > 0 }
        self.grid = self.grid.increment()
    }

    // MARK: - Private functions

    private func spawnChance() -> Int {
        let nEncounters = self.grid.nEncounters()
        let maxEncounters = 10
        let spawnChance: Int
        if nEncounters == 0 {
            spawnChance = 100
        } else {
            spawnChance = (((maxEncounters+1) - nEncounters) / nEncounters) * maxEncounters
        }
        dlog(String(format: "nEncounters = %d, spawnChance = %d", nEncounters, maxEncounters))
        return spawnChance
    }

    // MARK: - Life cycle

    init() {
        self.grid = Grid(width: constants.worldGridWidth, height: constants.worldGridHeight)
    }

    init(with grid: Grid) {
        self.grid = grid
    }
}
