//: Playground - noun: a place where people can play

/**
 * Recursive implementation of a binary search algorithm for a pre-sorted integer array.
 */

import Foundation
import XCTest

extension Array where Iterator.Element == Int {

    func find(_ value: Int) -> Int {
        return find(value, left: 0, right: count - 1)
    }
    
    private func find(_ value: Int, left: Int, right: Int) -> Int {
        guard left <= right else { return -1 }
        
        let center = left + (right - left) / 2
        let valueAtCenter = self[center]
        
        switch valueAtCenter {
        case let x where x < value:
            return find(value, left: center + 1, right: right)
        case let x where x > value:
            return find(value, left: left, right: center - 1)
        default:
            return center
        }
    }
}


// MARK: - Tests

// MARK: - Test empty array

XCTAssertEqual(-1, [].find(0))

// MARK: - Test one-element array

XCTAssertEqual(-1, [0].find(-1))
XCTAssertEqual(0, [0].find(0))
XCTAssertEqual(-1, [0].find(1))

// MARK: - Test two-element array

XCTAssertEqual(-1, [0,1].find(-1))
XCTAssertEqual(0, [0,1].find(0))
XCTAssertEqual(1, [0,1].find(1))
XCTAssertEqual(-1, [0,1].find(2))

// MARK: - Test odd-element array

XCTAssertEqual(-1, [0,1,2,3,4,5].find(-1))
XCTAssertEqual(0, [0,1,2,3,4,5].find(0))
XCTAssertEqual(1, [0,1,2,3,4,5].find(1))
XCTAssertEqual(2, [0,1,2,3,4,5].find(2))
XCTAssertEqual(3, [0,1,2,3,4,5].find(3))
XCTAssertEqual(4, [0,1,2,3,4,5].find(4))
XCTAssertEqual(5, [0,1,2,3,4,5].find(5))
XCTAssertEqual(-1, [0,1,2,3,4,5].find(6))

// MARK: - Test even-element array

XCTAssertEqual(-1, [0,1,2,3,4,5,6].find(-1))
XCTAssertEqual(0, [0,1,2,3,4,5,6].find(0))
XCTAssertEqual(1, [0,1,2,3,4,5,6].find(1))
XCTAssertEqual(2, [0,1,2,3,4,5,6].find(2))
XCTAssertEqual(3, [0,1,2,3,4,5,6].find(3))
XCTAssertEqual(4, [0,1,2,3,4,5,6].find(4))
XCTAssertEqual(5, [0,1,2,3,4,5,6].find(5))
XCTAssertEqual(6, [0,1,2,3,4,5,6].find(6))
XCTAssertEqual(-1, [0,1,2,3,4,5,6].find(7))

// MARK: - Test array with duplicate elements

XCTAssertEqual(-1, [0,0,1,1,1,2,2,3,3,3].find(-1))
XCTAssertEqual(1, [0,0,1,1,1,2,2,3,3,3].find(0))
XCTAssertEqual(4, [0,0,1,1,1,2,2,3,3,3].find(1))
XCTAssertEqual(5, [0,0,1,1,1,2,2,3,3,3].find(2))
XCTAssertEqual(7, [0,0,1,1,1,2,2,3,3,3].find(3))
XCTAssertEqual(-1, [0,0,1,1,1,2,2,3,3,3].find(4))

print("all done")
