//
//  Utils.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 26/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation

func random(max: Int) -> Int {
    let random = arc4random_uniform(UInt32(max))
    return Int(random)
}
