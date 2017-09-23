//
//  Action.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 13/09/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


protocol Actionable {
    var name: String {get}
    var remainingRounds: Int {get}
    mutating func increment()
}

enum Actions {
    case HailAction()

    static let allValues = [
        Actions.HailAction()
    ]
}

struct HailAction: Actionable {
    var remainingRounds = 3
    let radius = 3
    var name = "Hail"

    mutating func increment() {
        self.remainingRounds -= 1
    }
}
