//
//  sevendayrogueTests.swift
//  sevendayrogueTests
//
//  Created by Bart van Kuik on 20/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import XCTest
@testable import sevendayrogue

class sevendayrogueTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDie() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        (0..<100).forEach { _ in
            XCTAssert(1...6 ~= d6.roll(), "d6 rolls wrong")
            XCTAssert(1...10 ~= (d4+d6), "Combining d4 + d6 exceeded range")
            XCTAssert(1...12 ~= (2*d6), "2d6 exceeded range")
            XCTAssert(2...5 ~= (d4+1).roll(), "1d4+1 exceeded range")
        }
    }

    func testDieParsing() {
        if let die = Die(string: "d4+1") {
            XCTAssert(die.min == 2 && die.max == 5)
        } else {
            XCTFail()
        }

        if let die = Die(string: "d100+20") {
            XCTAssert(die.min == 21 && die.max == 120)
        } else {
            XCTFail()
        }

        if let die = Die(string: "d6+3") {
            XCTAssert(die.min == 4 && die.max == 9)
        } else {
            XCTFail()
        }

        if let die = Die(string: "d12+6") {
            XCTAssert(die.min == 7 && die.max == 18)
        } else {
            XCTFail()
        }

        if let die = Die(string: "d8") {
            XCTAssert(die.min == 1 && die.max == 8)
        } else {
            XCTFail()
        }
    }

    func testMonsterLoading() {
        let allMonsters = GameData.loadMonsters()
        XCTAssert(allMonsters.count > 0, "No monsters in game data")
    }

    func testWorld() {
        let world = World()

        let width = world.grid.width
        let height = world.grid.height

        (0..<100).forEach { _ in
            let location = world.grid.spawnLocation(at: Direction.random())
            XCTAssert(location.x == 0 || location.x == (width - 1) || location.y == 0 || location.y == (height - 1), "Spawn location is not at the edge")
        }
    }

    func testGridSpawnLocation() {
        let length = 10
        let grid = World.Grid(width: length, height: length)
        XCTAssert(grid.spawnLocation(at: .north).y == 0)
        XCTAssert(grid.spawnLocation(at: .east).x == length - 1)
        XCTAssert(grid.spawnLocation(at: .south).y == length - 1)
        XCTAssert(grid.spawnLocation(at: .west).x == 0)
    }

    func testGridSpawn() {
        let length = 10
        var grid = World.Grid(width: length, height: length)
        let encounter = WorldFactory.makeEncounter()
        let location = grid.spawnLocation(at: encounter.direction.opposite())
        grid[location.x, location.y].append(encounter: encounter)

        var nEncounters = 0
        for x in 0 ..< length {
            for y in 0 ..< length {
                nEncounters += grid[x,y].encounters.count
            }
        }
        XCTAssert(nEncounters == 1, "Spawn failed")
    }

    func testGridIncrement() {
        let length = 10
        var grid = World.Grid(width: length, height: length)
        let encounter = WorldFactory.makeEncounter()
        let location = grid.spawnLocation(at: encounter.direction.opposite())
        grid[location.x, location.y].append(encounter: encounter)

        grid = grid.increment()
        var nEncounters = 0
        var nextLocation: Location?
        for x in 0 ..< length {
            for y in 0 ..< length {
                if !grid[x,y].encounters.isEmpty {
                    nextLocation = Location(x: x, y: y)
                    nEncounters += 1
                }
            }
        }
        XCTAssert(location != nextLocation, "Spawn failed")
        XCTAssert(nEncounters == 1, "Increment failed")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
