//: Playground - noun: a place where people can play

/* 1.2.
 * Implement a function void reverse(char* str) in C or C++ which reverses a null-terminated string.
 */

import Foundation

extension String {
    
    var kindaReversed: String {
        var terminatedCopy = self + ";"
        
        // Swift strings are pain :(
        let length = terminatedCopy.reduce(0, { acc, next in return acc + 1}) - 1
        for i in 0..<(length / 2) {
            let leftIndex = terminatedCopy.index(startIndex, offsetBy: i)
            let rightIndex = terminatedCopy.index(startIndex, offsetBy: length - i - 1)
            let left = terminatedCopy[leftIndex]
            let right = terminatedCopy[rightIndex]
            terminatedCopy.remove(at: leftIndex)
            terminatedCopy.insert(right, at: leftIndex)
            terminatedCopy.remove(at: rightIndex)
            terminatedCopy.insert(left, at: rightIndex)
        }
        return String(terminatedCopy.dropLast())
    }
}

let tests = [
    "": "",
    "a": "a",
    "ab": "ba",
    "abcd": "dcba",
    "abcde": "edcba"
]

for test in tests {
    let result = test.0.kindaReversed
    print("test \"\(test.0)\": \(result == test.1 ? "passed" : "failed")")
}
