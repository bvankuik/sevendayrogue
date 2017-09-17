//
//  Area.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 13/09/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


struct Area {
    let origin: Location
    let radius: Int

    func contains(location: Location) -> Bool {
        let containsX: Bool
        let containsY: Bool

        if (self.origin.x - radius) <= location.x && (self.origin.x + radius) >= location.x {
            containsX = true
        } else {
            containsX = false
        }

        if (self.origin.y - radius) <= location.y && (self.origin.y + radius) >= location.y {
            containsY = true
        } else {
            containsY = false
        }

        let containsXY = (containsX && containsY)
        return containsXY
    }
}
