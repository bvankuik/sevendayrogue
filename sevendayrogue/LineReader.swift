//
//  LineReader.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 02/09/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import Foundation


class LineReader {
    let path: String

    fileprivate let file: UnsafeMutablePointer<FILE>!

    init?(path: String) {
        self.path = path

        file = fopen(path, "r")

        guard file != nil else { return nil }

    }

    var nextLine: String? {
        var line:UnsafeMutablePointer<CChar>? = nil
        var linecap:Int = 0
        defer { free(line) }
        return getline(&line, &linecap, file) > 0 ? String(cString: line!) : nil
    }

    deinit {
        fclose(file)
    }
}

extension LineReader: Sequence {
    func  makeIterator() -> AnyIterator<String> {
        return AnyIterator<String> {
            return self.nextLine
        }
    }
}


func readFile(filename: String) -> [String] {
    guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        return []
    }

    let path = dir.appendingPathComponent(filename)

    guard let reader = LineReader(path: path.absoluteString) else {
        return []
    }

    var lines: [String] = []
    for line in reader {
        print(">" + line.trimmingCharacters(in: .whitespacesAndNewlines))
        lines.append(line)
    }
    
    return lines
}
