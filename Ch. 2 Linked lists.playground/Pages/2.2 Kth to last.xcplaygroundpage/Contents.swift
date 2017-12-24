//: [Previous](@previous)

/*
 * Return Kth to Last: Implement an algorithm to  nd the kth to last element of a singly linked list.
 *
 * Here we assume that k=0 returns the last element - ZZ.
 */

import Foundation

extension SingleLinkedList {
    
    func kthToLast(_ k: Int) -> T? {
        guard k >= 0 else { return nil }
        
        var fastPointer = head
        var slowPointer = head
        
        for _ in 0..<k {
            fastPointer = fastPointer?.next
        }
        
        guard fastPointer != nil else { return nil }
        
        while fastPointer?.next != nil {
            fastPointer = fastPointer?.next
            slowPointer = slowPointer?.next
        }
        
        return slowPointer?.value
    }
}

let tests: [(array: [Int], k: Int, expected: Int?)] = [
    ([], 0, nil),
    ([1], 0, 1),
    ([1], 1, nil),
    ([1,2], 0, 2),
    ([1,2], 1, 1),
    ([1,2], 2, nil),
    ([1,2,3,4,5], 0, 5),
    ([1,2,3,4,5], 2, 3),
    ([1,2,3,4,5], 4, 1),
    ([1,2,3,4,5], 5, nil)
]

for test in tests {
    let ll = SingleLinkedList.from(test.array)
    let result = ll.kthToLast(test.k) == test.expected
    print("kth to last for \(test.array)-\(test.k) \(result.asTestResult)")
}

//: [Next](@next)
