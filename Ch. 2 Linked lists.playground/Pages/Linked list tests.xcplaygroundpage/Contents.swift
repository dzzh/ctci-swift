//: [Previous](@previous)

import Foundation

// TODO: Tests for the rest of the API

// MARK: - Tests for reversing the list

let reversingTests: [(original: [Int], reversed: [Int])] = [
    ([], []),
    ([1], [1]),
    ([1,2], [2,1]),
    ([1,2,3], [3,2,1]),
    ([1,1,1,1,1], [1,1,1,1,1])
]

for test in reversingTests {
    var ll = SingleLinkedList.from(test.original)
    ll.reverse()
    let result = ll.asArray == test.reversed
    print("test reversing \(test.original): \(result.asTestResult)")
}

//: [Next](@next)
