//: [Previous](@previous)

/*
 * Sum Lists: You have two numbers represented by a linked list, where each node contains a single digit.
 * The digits are stored in reverse order, such that the 1 's digit is at the head of the list.
 * Write a function that adds the two numbers and returns the sum as a linked list.
 * EXAMPLE
 * Input:(7-> 1 -> 6) + (5 -> 9 -> 2).That is, 617 + 295. Output:2 -> 1 -> 9.That is, 912.
 * FOLLOW UP
 * Suppose the digits are stored in forward order. Repeat the above problem.
 * EXAMPLE
 * Input:(6 -> 1 -> 7) + (2 -> 9 -> 5).That is, 617 + 295. Output:9 -> 1 -> 2.That is, 912.
 */

import Foundation

func sumReverseLists(a: SingleLinkedList<Int>, b: SingleLinkedList<Int>) -> SingleLinkedList<Int> {
    var result = SingleLinkedList<Int>()
    
    var aCurrent = a.head
    var bCurrent = b.head
    var resultCurrent: SingleLinkedNode<Int>?
    var overflow = 0
    
    while aCurrent != nil || bCurrent != nil {
        let sum = (aCurrent?.value ?? 0) + (bCurrent?.value ?? 0) + overflow
        let remainder = sum % 10
        overflow = sum >= 10 ? 1 : 0
        
        let resultNode = SingleLinkedNode(value: remainder)
        if resultCurrent == nil {
            result.head = resultNode
            resultCurrent = resultNode
        } else {
            resultCurrent?.next = resultNode
            resultCurrent = resultNode
        }
        
        aCurrent = aCurrent?.next
        bCurrent = bCurrent?.next
    }
    
    if overflow > 0 {
        resultCurrent?.next = SingleLinkedNode(value: overflow)
    }
    
    return result
}

// Reversing here will screw the original lists of course, in case this matters
func sumForwardLists(a: SingleLinkedList<Int>, b: SingleLinkedList<Int>) -> SingleLinkedList<Int> {
    var reversedA = SingleLinkedList(head: a.head)
    reversedA.reverse()
    
    var reversedB = SingleLinkedList(head: b.head)
    reversedB.reverse()
    
    var result = sumReverseLists(a: reversedA, b: reversedB)
    result.reverse()
    return result
}

// MARK: - Tests for reverse sum

let reverseTests: [(left: [Int], right: [Int], sum: [Int])] = [
    ([], [], []),
    ([1], [], [1]),
    ([], [1], [1]),
    ([1], [2], [3]),
    ([1], [1,1], [2,1]),
    ([5,6,7], [8], [3,7,7]),
    ([8], [5,6,7], [3,7,7]),
    ([9,9,9], [9,9,9], [8,9,9,1])
]

for test in reverseTests {
    let resultArray = sumReverseLists(a: SingleLinkedList.from(test.left), b: SingleLinkedList.from(test.right)).asArray
    let result = resultArray == test.sum
    print("test sumReverseLists \(test.left) and \(test.right): \(result.asTestResult)")
}

// MARK: - Tests for forward sum

let forwardTests: [(left: [Int], right: [Int], sum: [Int])] = [
    ([], [], []),
    ([1], [], [1]),
    ([], [1], [1]),
    ([1], [2], [3]),
    ([1], [1,1], [1,2]),
    ([5,6,7], [8], [5,7,5]),
    ([8], [5,6,7], [5,7,5]),
    ([9,9,9], [9,9,9], [1,9,9,8])
]

for test in forwardTests {
    let resultArray = sumForwardLists(a: SingleLinkedList.from(test.left), b: SingleLinkedList.from(test.right)).asArray
    let result = resultArray == test.sum
    print("test sumForwardLists \(test.left) and \(test.right): \(result.asTestResult)")
}

//: [Next](@next)
