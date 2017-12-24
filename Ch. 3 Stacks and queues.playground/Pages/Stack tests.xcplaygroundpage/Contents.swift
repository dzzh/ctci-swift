//: Playground - noun: a place where people can play

import Foundation
import XCTest

// TODO: more tests would not hurt, e.g. for Comparable protocol conformance

// MARK: - Test array conversion

let arrayConversionTests: [(original: [Int], modified: [Int])] = [
    ([], []),
    ([1], [1]),
    ([1,2], [1,2]),
    ([1,2,3], [1,2,3]),
    ([1,1,1,1,1], [1,1,1,1,1])
]

for test in arrayConversionTests {
    let result = Stack.from(test.original).asArray
    XCTAssertEqual(test.modified, result)
}

// MARK: - Interface tests

let emptyStack = Stack<Int>()
let stackWithAHead = Stack(head: 5)

// MARK: - isEmpty

XCTAssert(emptyStack.isEmpty)
XCTAssertFalse(stackWithAHead.isEmpty)

// MARK: - peek

XCTAssertNil(emptyStack.peek())
XCTAssertEqual(5, stackWithAHead.peek())

// MARK: - push

var pushStack = Stack<Int>()
pushStack.push(3)
pushStack.push(2)
pushStack.push(1)
XCTAssertEqual([1,2,3], pushStack.asArray)

// MARK: - pop

var popStack = Stack.from([1,2,3])
XCTAssertEqual(1, popStack.pop())
XCTAssertEqual(2, popStack.pop())
XCTAssertEqual(3, popStack.pop())
XCTAssertNil(popStack.pop())

print("We good, Honey Bunny, we good")








