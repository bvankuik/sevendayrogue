//
//  World.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 23/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


extension World {
    struct CreatureNames {
        var race: Creature.Race
        var firstNames: [String]
        var lastNames: [String]
    }
}

extension World {
    struct Grid {
        private var surface: Array<Array<Square>>

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
    let creatureNamesList: [CreatureNames]
    let baseLocation: Location
    let grid: Grid

    var epoch = 0
    var spawnChance = 50

    init() {
        let namesHumanMale = readFile(filename: "names_human_male.txt")

        self.creatureNamesList = [
            CreatureNames(race: .human, firstNames: namesHumanMale, lastNames: namesHumanMale)
        ]
        let width = 30
        let height = 30
        self.grid = Grid(width: 30, height: 30)
        self.baseLocation = Location(row: width/2, col: height/2)
    }
}
