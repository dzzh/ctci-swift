//: [Previous](@previous)

/*
 * Stack of Plates: Imagine a (literal) stack of plates. If the stack gets too high, it might topple.
 * Therefore, in real life, we would likely start a new stack when the previous stack exceeds some threshold.
 * Implement a data structure SetOfStacks that mimics this.
 * SetOfStacks should be composed of several stacks and should create a new stack once the previous one exceeds capacity.
 * SetOfStacks.push() and SetOfStacks.pop() should behave identically to a single stack
 * (that is, pop() should return the same values as it would if there were just a single stack).
 * FOLLOW UP
 * Implement a function popAt(int index) which performs a pop operation on a specific substack.
 */

import Foundation
import XCTest

class StackOfStacks<T: Comparable>: StackProtocol {
    
    let threshold: Int
    private(set) var stacks = Stack<Stack<T>>()
    
    init(threshold: Int, head: T? = nil) {
        self.threshold = threshold
        if let head = head {
            let stack = Stack(head: head)
            stacks.push(stack)
        }
    }
    
    // MARK: - StackProtocol
    
    var isEmpty: Bool {
        return stacks.isEmpty
    }
    
    func pop() -> T? {
        guard let headStack = stacks.peek() else { return nil }
        let popped = headStack.pop()
        if headStack.isEmpty {
            _ = stacks.pop()
        }
        return popped
    }
    
    func peek() -> T? {
        return stacks.peek()?.peek()
    }
    
    func push(_ value: T) {
        guard let headStack = stacks.peek(), headStack.count < threshold else {
            let stack = Stack(head: value)
            stacks.push(stack)
            return
        }
        headStack.push(value)
    }
    
    var asArray: [T] {
        var result = [T]()
        
        var _currentStackNode = stacks.head
        
        while let currentStackNode = _currentStackNode {
            let stack = currentStackNode.value
            var _currentElement = stack.head
            while let currentElement = _currentElement {
                result.append(currentElement.value)
                _currentElement = currentElement.next
            }
            _currentStackNode = currentStackNode.next
        }
        
        return result
    }
    
    // MARK: - Helpers
    
    static func from(_ array: [T], threshold: Int) -> StackOfStacks<T> {
        let stack = StackOfStacks<T>(threshold: threshold)
        for item in array.reversed() {
            stack.push(item)
        }
        return stack
    }
    
    /// Pops element from a stack at given index. If the stack gets empty, it gets dropped.
    /// Here, we don't implement roll-over, a stack in the middle with an element popped remains not full.
    /// - parameter index: index of a stack to pop from, starting with 0 at head stack
    /// - returns popped element or nil if the index is incorrect
    func pop(at index: Int) -> T? {
        guard index >= 0 else { return nil }
        guard index > 0 else { return pop() }
        
        var previousStack = stacks.head
        var currentIndex = 1
        while currentIndex < index, previousStack?.next != nil {
            currentIndex += 1
            previousStack = previousStack?.next
        }
        
        guard let currentStack = previousStack?.next else { return nil }
        let popped = currentStack.value.pop()
        if currentStack.value.isEmpty {
            previousStack?.next = currentStack.next
        }
        
        return popped
    }
}

// TODO: Clearly this is not a production-grade test set

// MARK: - Tests for original problem

let emptyStack = StackOfStacks<Int>(threshold: 2)
let stackWithAHead = StackOfStacks(threshold: 2, head: 1)

XCTAssert(emptyStack.isEmpty)
XCTAssertNil(emptyStack.pop())

XCTAssertFalse(stackWithAHead.isEmpty)
XCTAssertEqual(1, stackWithAHead.peek())
XCTAssertEqual(1, stackWithAHead.pop())

let stackOfFive = StackOfStacks(threshold: 2, head: 5)

// Push elements
XCTAssertEqual(1, stackOfFive.stacks.count)
stackOfFive.push(4)
XCTAssertEqual(1, stackOfFive.stacks.count)
stackOfFive.push(3)
XCTAssertEqual(2, stackOfFive.stacks.count)
stackOfFive.push(2)
XCTAssertEqual(2, stackOfFive.stacks.count)
stackOfFive.push(1)
XCTAssertEqual(3, stackOfFive.stacks.count)

// Pop elements
XCTAssertEqual(1, stackOfFive.pop())
XCTAssertEqual(2, stackOfFive.stacks.count)
XCTAssertEqual(2, stackOfFive.pop())
XCTAssertEqual(2, stackOfFive.stacks.count)
XCTAssertEqual(3, stackOfFive.pop())
XCTAssertEqual(1, stackOfFive.stacks.count)
XCTAssertEqual(4, stackOfFive.pop())
XCTAssertEqual(1, stackOfFive.stacks.count)
XCTAssertEqual(5, stackOfFive.pop())
XCTAssertEqual(0, stackOfFive.stacks.count)

// MARK: - Tests for pop(at:)

let array = [1,2,3,4,5] // aka [1],[2,3],[4,5]
let popAtStack = StackOfStacks.from(array, threshold: 2)

popAtStack.pop(at: 1)
XCTAssertEqual(3, popAtStack.stacks.count)
XCTAssertEqual([1,3,4,5], popAtStack.asArray)

popAtStack.pop(at: 1)
XCTAssertEqual(2, popAtStack.stacks.count)
XCTAssertEqual([1,4,5], popAtStack.asArray)

popAtStack.pop(at: 1)
XCTAssertEqual(2, popAtStack.stacks.count)
XCTAssertEqual([1,5], popAtStack.asArray)

popAtStack.pop(at: 1)
XCTAssertEqual(1, popAtStack.stacks.count)
XCTAssertEqual([1], popAtStack.asArray)

popAtStack.pop(at: 1)
XCTAssertEqual(1, popAtStack.stacks.count)
XCTAssertEqual([1], popAtStack.asArray)

popAtStack.pop(at: 0)
XCTAssertEqual(0, popAtStack.stacks.count)
XCTAssertEqual([], popAtStack.asArray)

print("Ready to rock'n'roll")

//: [Next](@next)
