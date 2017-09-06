//
//  Logger.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 06/09/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import UIKit


func dlog(_ format: String = "", _ args: [CVarArg] = [], file: String = #file, function: String = #function, line: Int = #line) {

    let filename: String
    if let fn = URL(string:file)?.lastPathComponent.components(separatedBy: ".").first {
        filename = fn
    } else {
        filename = "nil"
    }

    let formattedString = String(format: "\(filename).\(function) line \(line) $ \(format)", arguments: args)
    //    xcodePrint(formattedString: formattedString)
    NSLog(formattedString)
}


class Stopwatch {
    static let shared = Stopwatch()

    private var startTime: CFAbsoluteTime = 0

    func start() {
        self.startTime = CFAbsoluteTimeGetCurrent()
    }

    func lap(_ format: String = "", _ args: [CVarArg] = [], file: String = #file, function: String = #function, line: Int = #line) {
        let duration = CFAbsoluteTimeGetCurrent() - startTime
        let filename: String

        if let fn = URL(string:file)?.lastPathComponent.components(separatedBy: ".").first {
            filename = fn
        } else {
            filename = "nil"
        }

        let msg: String
        if format.isEmpty {
            msg = String(format: "\(filename).\(function) line \(line) $ lap time: \(duration)")
        } else {
            msg = String(format: "\(filename).\(function) line \(line) $ lap time: \(duration) $ comment: \(format)", arguments: args)
        }
        print(msg)
    }

    func reset() {
        self.start()
    }
    
}
