//: [Previous](@previous)

/*
 * Partition: Write code to partition a linked list around a value x,
 * such that all nodes less than x come before all nodes greater than or equal to x.
 * If x is contained within the list, the values of x only need to be after the elements less than x (see below).
 * The partition element x can appear anywhere in the "right partition";
 * it does not need to appear between the left and right partitions.
 * EXAMPLE
 * Input: 3 -> 5 -> 8 -> 5 -> 10 -> 2 -> 1[partition=5]
 * Output: 3 -> 1 -> 2 -> 10 -> 5 -> 5 -> 8
 */

import Foundation

extension SingleLinkedList {
    
    mutating func partition(around pivot: T) {
        var leftPartition = SingleLinkedList<T>()
        var rightPartition = SingleLinkedList<T>()
        
        var previous: SingleLinkedNode<T>?
        var current = head
        while current != nil {
            // as a part of partitioning procedure we have to cut outgoing link for the moved nodes
            previous?.next = nil
            
            // append here is inefficient, would be better to cache list tails and append to them,
            // but "let's leave it as an exercise for a curious readed"
            if current!.value < pivot {
                leftPartition.append(current!)
            } else {
                rightPartition.append(current!)
            }
            previous = current
            current = current?.next
        }
        
        if let leftHead = leftPartition.head {
            if let rightHead = rightPartition.head {
                leftPartition.append(rightHead)
            }
            head = leftHead
        } else {
            head = rightPartition.head
        }
    }
}

let tests: [(original: [Int], pivot: Int, partitioned: [Int])] = [
    ([],5,[]),
    ([1], 5, [1]),
    ([6], 5, [6]),
    ([1,2,3], 5, [1,2,3]),
    ([6,7,8], 5, [6,7,8]),
    ([5,5,5], 5, [5,5,5]),
    ([3,5,8,5,10,2,1], 5, [3,2,1,5,8,5,10])
]

for test in tests {
    var ll = SingleLinkedList.from(test.original)
    ll.partition(around: test.pivot)
    let result = ll.asArray == test.partitioned
    print("test partitioning \(test.original) around \(test.pivot): \(result.asTestResult)")
}

//: [Next](@next)
