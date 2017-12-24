//: [Previous](@previous)

/*
 * Delete Middle Node: Implement an algorithm to delete a node in the middle
 * (i.e., any node but the first and last node, not necessarily the exact middle)
 * of a singly linked list, given only access to that node.
 * EXAMPLE
 * Input: the node c from the linked list a->b->c->d->e->f
 * Result: nothing is returned, but the new linked list looks like a->b->d->e- >f
 */

import Foundation

extension SingleLinkedList {
    
    func lookMaDeleteNoHeads(_ node: SingleLinkedNode<T>) {
        guard let nextNode = node.next else { return }
        
        node.value = nextNode.value
        node.next = nextNode.next
    }
}

let tests: [(array: [Int], toDelete: Int, expected: [Int])] = [
    ([1,2,3], 2, [1,3]),
    ([1,2,3,4,5], 2, [1,3,4,5]),
    ([1,2,3,4,5], 3, [1,2,4,5]),
    ([1,2,3,4,5], 4, [1,2,3,5])
]

for test in tests {
    let ll = SingleLinkedList.from(test.array)
    
    // Find a node with given value in LL to delete it
    var node: SingleLinkedNode<Int>?
    var current = ll.head
    while current != nil {
        if current?.value == test.toDelete {
            node = current
            break
        }
        current = current?.next
    }
    
    guard let nodeToDelete = node else {
        print("no node to delete, fail")
        continue
    }
    
    ll.lookMaDeleteNoHeads(nodeToDelete)
    let result = ll.asArray == test.expected
    print("test deleting \(test.toDelete) from \(test.array): \(result.asTestResult)")
}

//: [Next](@next)
