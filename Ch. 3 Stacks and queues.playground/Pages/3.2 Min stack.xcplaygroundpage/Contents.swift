//: [Previous](@previous)

/*
 * Stack Min: How would you design a stack which, in addition to push and pop, has a function min
 * which returns the minimum element? Push, pop and min should all operate in 0(1) time.
 */

import Foundation
import XCTest

class MinStack<T: Comparable>: Stack<T> {
    
    let minStack = Stack<T>()
    
    override init(head: T? = nil) {
        if let head = head {
            minStack.push(head)
        }
        super.init(head: head)
    }
    
    override func pop() -> T? {
        let popped = super.pop()
        if popped != nil && popped == minStack.peek() {
            _ = minStack.pop()
        }
        return popped
    }
    
    override func push(_ value: T) {
        if minStack.peek() == nil || value <= minStack.peek()! {
            minStack.push(value)
        }
        super.push(value)
    }
    
    var min: T? {
        return minStack.peek()
    }
    
    static func minFrom(_ array: [T]) -> MinStack<T> {
        let stack = MinStack<T>()
        for item in array.reversed() {
            stack.push(item)
        }
        return stack
    }
}

// MARK: - Tests

let emptyStack = MinStack<Int>()
let stackWithAHead = MinStack(head: 5)

XCTAssertNil(emptyStack.min)
XCTAssertEqual(5, stackWithAHead.min)

// 1 2 3 - min element at the top
let increasingStack = MinStack<Int>()
increasingStack.push(3)
XCTAssertEqual(3, increasingStack.min)
increasingStack.push(2)
XCTAssertEqual(2, increasingStack.min)
increasingStack.push(1)
XCTAssertEqual(1, increasingStack.min)
increasingStack.pop()
XCTAssertEqual(2, increasingStack.min)
increasingStack.pop()
XCTAssertEqual(3, increasingStack.min)
increasingStack.pop()
XCTAssertNil(increasingStack.min)

// 3 2 1 - min element at the bottom
let decreasingStack = MinStack<Int>()
decreasingStack.push(1)
XCTAssertEqual(1, decreasingStack.min)
decreasingStack.push(2)
XCTAssertEqual(1, decreasingStack.min)
decreasingStack.push(3)
XCTAssertEqual(1, decreasingStack.min)
decreasingStack.pop()
XCTAssertEqual(1, decreasingStack.min)
decreasingStack.pop()
XCTAssertEqual(1, decreasingStack.min)
decreasingStack.pop()
XCTAssertNil(decreasingStack.min)

// 1 2 1 3 - min element is seen twice
let stackWithDuplicates = MinStack<Int>()

stackWithDuplicates.push(3)
XCTAssertEqual(3, stackWithDuplicates.min)
stackWithDuplicates.push(1)
XCTAssertEqual(1, stackWithDuplicates.min)
stackWithDuplicates.push(2)
XCTAssertEqual(1, stackWithDuplicates.min)
stackWithDuplicates.push(1)
XCTAssertEqual(1, stackWithDuplicates.min)

// 1 2 1 3
stackWithDuplicates.pop()
XCTAssertEqual(1, stackWithDuplicates.min)
// 2 1 3
stackWithDuplicates.pop()
XCTAssertEqual(1, stackWithDuplicates.min)
// 1 3
stackWithDuplicates.pop()
XCTAssertEqual(3, stackWithDuplicates.min)
// 3
stackWithDuplicates.pop()
XCTAssertNil(stackWithDuplicates.min)

print("Looks good")

//: [Next](@next)
