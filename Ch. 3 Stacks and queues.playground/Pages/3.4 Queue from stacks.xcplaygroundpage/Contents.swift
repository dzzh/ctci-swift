//: [Previous](@previous)

import Foundation
import XCTest

class QueueFromStacks<T: Comparable>: QueueProtocol {
    
    private enum ActiveStack {
        case backward
        case forward
    }
    
    private let forwardStack = Stack<T>()
    private let backwardStack = Stack<T>()
    private var activeStack: ActiveStack = .backward
    
    init(head: T? = nil) {
        if let head = head {
            backwardStack.push(head)
        }
    }
    
    // MARK: - QueueProtocol
    
    var isEmpty: Bool {
        return forwardStack.isEmpty && backwardStack.isEmpty
    }
    
    func add(_ value: T) {
        switch activeStack {
        case .forward:
            activeStack = .backward
            moveData(from: forwardStack, to: backwardStack)
            fallthrough
        case .backward:
            backwardStack.push(value)
        }
    }
    
    func remove() -> T? {
        switch activeStack {
        case .backward:
            activeStack = .forward
            moveData(from: backwardStack, to: forwardStack)
            fallthrough
        case .forward:
            return forwardStack.pop()
        }
    }
    
    func peek() -> T? {
        switch activeStack {
        case .backward:
            activeStack = .forward
            moveData(from: backwardStack, to: forwardStack)
            fallthrough
        case .forward:
            return forwardStack.peek()
        }
    }
    
    var asArray: [T] {
        switch activeStack {
        case .backward:
            activeStack = .forward
            moveData(from: backwardStack, to: forwardStack)
            fallthrough
        case .forward:
            return forwardStack.asArray
        }
    }
}

private extension QueueFromStacks {
    
    func moveData(from sourceStack: Stack<T>, to destinationStack: Stack<T>) {
        while !destinationStack.isEmpty {
            _ = destinationStack.pop()
        }
        
        while !sourceStack.isEmpty {
            guard let next = sourceStack.pop() else {
                print("oops")
                return
            }
            destinationStack.push(next)
        }
    }
}

// MARK: - Tests

let emptyQueue = QueueFromStacks<Int>()
let queueWithAHead = QueueFromStacks(head: 5)

XCTAssert(emptyQueue.isEmpty)
XCTAssertFalse(queueWithAHead.isEmpty)

let queueWithValues = QueueFromStacks<Int>()
queueWithValues.add(1)
queueWithValues.add(2)
queueWithValues.add(3)
queueWithValues.add(4)
queueWithValues.add(5)

XCTAssertEqual([1,2,3,4,5], queueWithValues.asArray)

var removed = queueWithValues.remove()
XCTAssertEqual(1, removed)

removed = queueWithValues.remove()
XCTAssertEqual(2, removed)
XCTAssertEqual([3,4,5], queueWithValues.asArray)

queueWithValues.add(6)
XCTAssertEqual([3,4,5,6], queueWithValues.asArray)

removed = queueWithValues.remove()
XCTAssertEqual(3, removed)
removed = queueWithValues.remove()
XCTAssertEqual(4, removed)
removed = queueWithValues.remove()
XCTAssertEqual(5, removed)
removed = queueWithValues.remove()
XCTAssertEqual(6, removed)
XCTAssert(queueWithValues.isEmpty)

print("And we're good to launch this to the Moon")

//: [Next](@next)
