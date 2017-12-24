//: [Previous](@previous)

import Foundation
import XCTest

extension Stack {
    
    func sort(asc: Bool = true) -> Stack<T> {
        let tempStack = Stack<T>()
        
        while !isEmpty {
            let popped = pop()!
            
            if tempStack.isEmpty {
                tempStack.push(popped)
                continue
            } else {
                // pretty much an insertion sort:
                // 1. move the values to temp stack until reaching an unsorted pair
                // 2. after finding an unsorted pair, move values back
                // with unsorted element put in place for as long as necessary
                if isValue(popped, greaterThanOrEqualTo: tempStack.peek()!, asc: asc) {
                    tempStack.push(popped)
                    continue
                } else {
                    flush(tempStack, buffer: popped, asc: asc)
                }
            }
        }
        
        while !tempStack.isEmpty {
            push(tempStack.pop()!)
        }
        
        return self
    }
    
}

private extension Stack {
    
    /// Flush the contents of given temp stack and buffer value into self.
    /// After the operation is completed, contents of the temp stack and the buffer value
    /// will be pushed to self, with buffer value being sorted relatively to the items
    /// previously contained in the temp stack.
    /// - parameter tempStack: temporary stack to flush
    /// - paramter buffer: additional buffer value to flush
    /// - parameter asc: sort in ascending order if set to true, in descending order otherwise
    func flush(_ tempStack: Stack<T>, buffer: T, asc: Bool) {
        while !tempStack.isEmpty {
            let peek = tempStack.peek()!
            if isValue(buffer, greaterThan: peek, asc: asc) {
                push(buffer)
                return
            } else {
                push(tempStack.pop()!)
                continue
            }
        }
        push(buffer)
    }
    
    func isValue(_ a: T, greaterThan b: T, asc: Bool) -> Bool {
        return asc ? a > b : b > a
    }
    
    func isValue(_ a: T, greaterThanOrEqualTo b: T, asc: Bool) -> Bool {
        return asc ? a >= b : b >= a
    }
}

let emptyArray = [Int]()
let defaultArray = [1,2,3,4,5]
let reversedArray = [5,4,3,2,1]

XCTAssertEqual(emptyArray, Stack.from(emptyArray).sort(asc: true).asArray)
XCTAssertEqual(emptyArray, Stack.from(emptyArray).sort(asc: false).asArray)

XCTAssertEqual(defaultArray, Stack.from(defaultArray).sort(asc: true).asArray)
XCTAssertEqual(reversedArray, Stack.from(defaultArray).sort(asc: false).asArray)

XCTAssertEqual(defaultArray, Stack.from(reversedArray).sort(asc: true).asArray)
XCTAssertEqual(reversedArray, Stack.from(reversedArray).sort(asc: false).asArray)


let unsortedArray = [4,3,1,2,5]
XCTAssertEqual(defaultArray, Stack.from(unsortedArray).sort(asc: true).asArray)
XCTAssertEqual(reversedArray, Stack.from(unsortedArray).sort(asc: false).asArray)


let duplicatesArray = [1,1,3,3,2,2,1,2,3,2,1]
let sortedDuplicatesArray = duplicatesArray.sorted()
let reversedDuplicatesArray: [Int] = sortedDuplicatesArray.reversed()
XCTAssertEqual(sortedDuplicatesArray, Stack.from(duplicatesArray).sort(asc: true).asArray)
XCTAssertEqual(reversedDuplicatesArray, Stack.from(duplicatesArray).sort(asc: false).asArray)


let longArray = [1,5,7,2,4,1,2,3,2,1,5,6,4,3,2,6,1,2,5,4,3]
let sortedLongArray = longArray.sorted()
let reversedLongArray: [Int] = sortedLongArray.reversed()
XCTAssertEqual(sortedLongArray, Stack.from(longArray).sort(asc: true).asArray)
XCTAssertEqual(reversedLongArray, Stack.from(longArray).sort(asc: false).asArray)

print("Suddenly works")

//: [Next](@next)
