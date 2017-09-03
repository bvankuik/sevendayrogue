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
    let offset: Int
    var min: Int {
        return 1 + self.offset
    }
    var max: Int {
        return self.pips + self.offset
    }

    func roll() -> Int {
        let outcome =  1 + Int(arc4random_uniform(UInt32(self.pips))) + self.offset
        return outcome
    }

    init(pips: Int) {
        self.pips = pips
        self.offset = 0
    }

    init(pips: Int, offset: Int) {
        self.pips = pips
        self.offset = offset
    }

    init?(string: String) {
        if !string.hasPrefix("d") {
            return nil
        }

        let plusSplit = string.components(separatedBy: "+")
        if plusSplit.count == 1 {
            // format: dX
            let dsplit = string.components(separatedBy: "d")
            if let pipsString = dsplit.last, let pips = Int(pipsString) {
                self.pips = pips
                self.offset = 0
            } else {
                return nil
            }
        } else if plusSplit.count == 2 {
            // format: dX+Y
            let dsplit = plusSplit[0].components(separatedBy: "d")
            if let pipsString = dsplit.last, let pips = Int(pipsString), let offset = Int(plusSplit[1]) {
                self.pips = pips
                self.offset = offset
            } else {
                return nil
            }
        } else {
            return nil
        }
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

func +(left: Die, right: Int) -> Die {
    let die = Die(pips: left.pips, offset: right)
    return die
}

func *(left: Int, right: Die) -> Int {
    var outcome = 0
    (0..<left).forEach { _ in
        outcome += right.roll()
    }
    return outcome
}
