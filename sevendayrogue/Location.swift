//
//  Location.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 26/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


struct Location: Equatable {
    let x: Int
    let y: Int

    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    static func +(lhs: Location, rhs: Location) -> Location {
        return Location(
            x: lhs.x + rhs.x,
                        y: lhs.y + rhs.y)
    }

    func adjacent(to other: Location) -> Bool {
        let distX = abs(self.x - other.x)
        let distY = abs(self.y - other.y)

        if distX <= 1 && distY <= 1 {
            return true
        } else {
            return false
        }
    }
}

