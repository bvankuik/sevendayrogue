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

        func spawnLocation() -> Location {
            let edge = Direction.random()

            let location: Location
            switch edge {
            case .north:
                location = Location(row: 0, col: random(max: self.width))
            case .east:
                location = Location(row: random(max: self.height), col: self.width - 1)
            case .south:
                location = Location(row: self.height - 1, col: random(max: self.width))
            case .west:
                location = Location(row: random(max: self.height), col: 0)
            }

            return location
        }

        func square(for location: Location) -> Square {
            return self.surface[location.row][location.col]
        }

        subscript(row: Int, col: Int) -> Square {
            get {
                return self.surface[row][col]
            }
            set {
                self.surface[row][col] = newValue
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
    }
}

struct World {
    var creatures: [Creature]
    let baseLocation: Location
    let grid: Grid

    var epoch = 0
    var spawnChance = 50

    init() {
        let width = 40
        let height = 30
        self.grid = Grid(width: 30, height: 30)
        self.baseLocation = Location(row: width/2, col: height/2)
        self.creatures = []
    }
}
