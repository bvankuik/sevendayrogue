//
//  Direction.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 26/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation

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
