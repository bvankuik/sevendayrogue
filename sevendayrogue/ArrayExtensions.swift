//
//  ArrayExtensions.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 03/09/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


extension Array {

    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }

}
