//
//  Ability.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 23/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation

protocol Ability {
    var name: String {get set}
    var score: Int {get set}
}

extension Ability {
    var modifier: Int {
        switch self.score {
        case 1: return -5
        case 2...3: return -4
        case 4...5: return -3
        case 6...7: return -2
        case 8...9: return -1
        case 10...11: return 0
        case 12...13: return 1
        case 14...15: return 2
        case 16...17: return 3
        case 18...19: return 4
        case 20...21: return 5
        case 22...23: return 6
        case 24...25: return 7
        case 26...27: return 8
        case 28...29: return 9
        default: return 10
        }
    }
}

struct Muscle: Ability {
    var name = "Muscle"
    var score: Int

    init(score: Int) {
        self.score = score
    }
}

struct Agility: Ability {
    var name = "Agility"
    var score: Int

    init(score: Int) {
        self.score = score
    }
}

struct Fortitude: Ability {
    var name = "Fortitude"
    var score: Int

    init(score: Int) {
        self.score = score
    }
}

struct Cleverness: Ability {
    var name = "Cleverness"
    var score: Int

    init(score: Int) {
        self.score = score
    }
}

struct Judgment: Ability {
    var name = "Judgment"
    var score: Int

    init(score: Int) {
        self.score = score
    }
}

struct Charm: Ability {
    var name = "Charm"
    var score: Int

    init(score: Int) {
        self.score = score
    }
}
