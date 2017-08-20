//
//  Die.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 20/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


struct Die {

    let pips: Int

    func roll() -> Int {
        let outcome =  1 + Int(arc4random_uniform(UInt32(self.pips)))
        return outcome
    }

    init(pips: Int) {
        self.pips = pips
    }

}

// MARK: - All dies as constants

let d4 = Die(pips: 4)
let d6 = Die(pips: 6)
let d8 = Die(pips: 8)
let d10 = Die(pips: 10)
let d12 = Die(pips: 12)
let d20 = Die(pips: 20)
let d100 = Die(pips: 100)

// MARK: - Operator overloading for die

func +(left: Die, right: Die) -> Int {
    return left.roll() + right.roll()
}

func +(left: Die, right: Int) -> Int {
    return left.roll() + right
}

func *(left: Int, right: Die) -> Int {
    var outcome = 0
    (0..<left).forEach { _ in
        outcome += right.roll()
    }
    return outcome
}
