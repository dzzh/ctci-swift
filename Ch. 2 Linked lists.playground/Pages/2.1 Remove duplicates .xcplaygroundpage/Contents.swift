//: [Previous](@previous)

/*
 * Write code to remove duplicates from an unsorted linked list.
 * FOLLOW UP
 * How would you solve this problem if a temporary buffer is not allowed?
 *
 */

import Foundation

extension SingleLinkedList {
    
    // One other solution would be to sort the LL first
    // (e.g. by wrapping it into an array and unwrapping back)
    func removeDuplicatesWithBuffer() {
        var buffer = Set<T>()
        var previous = head
        var current = head?.next
        
        if let headValue = head?.value {
            buffer.insert(headValue)
        }
        
        while current != nil {
            let value = current!.value
            if buffer.contains(value) {
                previous?.next = current?.next
                current = current?.next
            } else {
                buffer.insert(current!.value)
                current = current?.next
                previous = previous?.next
            }
        }
    }
    
    func removeDuplicatesWithoutBuffer() {
        var slowPointer = head
        
        while slowPointer != nil {
            var fastPointer = slowPointer
            while fastPointer?.next != nil {
                if fastPointer?.next?.value == slowPointer?.value {
                    fastPointer?.next = fastPointer?.next?.next
                } else {
                    fastPointer = fastPointer?.next
                }
            }
            slowPointer = slowPointer?.next
        }
    }
}

let tests: [(original: [Int], modified: [Int])] = [
    ([], []),
    ([1], [1]),
    ([1,2,3], [1,2,3]),
    ([1,1], [1]),
    ([1,1,1], [1]),
    ([1,2,3,1,2,3,3,2,1,1,4,1,2,5,1], [1,2,3,4,5])
]

for test in tests {
    let ll1 = SingleLinkedList.from(test.original)
    ll1.removeDuplicatesWithoutBuffer()
    let array1 = ll1.asArray
    
    let ll2 = SingleLinkedList.from(test.original)
    ll2.removeDuplicatesWithBuffer()
    let array2 = ll2.asArray
    
    let result = array1 == array2 && array1 == test.modified
    print("test removing dups from \(test.original): \(result.asTestResult)")
}

//: [Next](@next)
