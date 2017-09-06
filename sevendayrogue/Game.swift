//
//  Game.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 06/09/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


class Game {

    static let instance = Game()

    var world: World

    init() {
        self.world = WorldFactory.makeWorld()
    }
}
