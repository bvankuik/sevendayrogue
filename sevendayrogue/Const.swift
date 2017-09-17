//
//  Const.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 06/09/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import UIKit
import CoreGraphics

struct Constants {
    let worldGridWidth = 20
    let worldGridHeight = 15
    let gridFontSize: CGFloat
    let baseFontSize: CGFloat

    init() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.gridFontSize = 25.0
            self.baseFontSize = self.gridFontSize + 20.0
        } else {
            self.gridFontSize = 15.0
            self.baseFontSize = self.gridFontSize + 10.0
        }
    }
}

let constants = Constants()
