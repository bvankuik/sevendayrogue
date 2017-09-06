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
}

