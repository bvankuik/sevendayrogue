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

    func testWorld() {
        let world = World()
        XCTAssert(!world.creatureNamesList.isEmpty, "World has no creature names")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
