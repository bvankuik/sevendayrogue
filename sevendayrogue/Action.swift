//
//  Action.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 13/09/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


protocol Action {
    var remainingRounds: Int {get}
    mutating func increment()
}


struct HailAction: Action {
    var remainingRounds = 3
    let radius = 3

    mutating func increment() {
        self.remainingRounds -= 1
    }
}
