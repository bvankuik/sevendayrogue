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

    func testWorld() {
        let world = World()

        let width = world.grid.width
        let height = world.grid.height

        (0..<100).forEach { _ in
            let location = world.grid.spawnLocation()
            XCTAssert(location.col == 0 || location.col == (width - 1) || location.row == 0 || location.row == (height - 1), "Spawn location is not at the edge")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
