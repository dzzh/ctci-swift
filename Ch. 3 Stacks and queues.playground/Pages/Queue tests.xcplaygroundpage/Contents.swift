//: [Previous](@previous)

import Foundation
import XCTest

// TODO: more tests wouldn't hurt here

// MARK: - Test array conversion

let arrayConversionTests: [(original: [Int], modified: [Int])] = [
    ([], []),
    ([1], [1]),
    ([1,2], [1,2]),
    ([1,2,3], [1,2,3]),
    ([1,1,1,1,1], [1,1,1,1,1])
]

for test in arrayConversionTests {
    let result = Queue.from(test.original).asArray
    XCTAssertEqual(test.modified, result)
}

//: [Next](@next)
