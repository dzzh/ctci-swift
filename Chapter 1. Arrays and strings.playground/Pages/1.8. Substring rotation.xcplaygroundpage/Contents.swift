//: [Previous](@previous)

/*
 * Assume you have a method isSubstring which checks if one word is a substring of another.
 * Given two strings, s1 and s2, write code to check if s2 is a rotation of s1
 * using only one call to isSubstring (e.g.,"waterbottle" is a rotation of "erbottlewat").
 */

import Foundation

extension String {
    
    func isRotation(of other: String) -> Bool {
        let doubleString = self + self
        return other.isSubstring(of: doubleString)
    }
    
    func isSubstring(of other: String) -> Bool {
        guard count <= other.count else { return false }
        
        var otherCopy = other
        var nextIndex = otherCopy.index(of: self[startIndex])
        while nextIndex != nil {
            // make otherCopy start with the same symbol as self
            otherCopy.removeSubrange(other.startIndex..<nextIndex!)
            if otherCopy.hasPrefix(self) {
                return true
            } else {
                otherCopy = String(otherCopy.dropFirst())
                nextIndex = otherCopy.index(of: self[startIndex])
            }
        }
        return false
    }
}

let substringTests: [String: Bool] = [
    "a,a": true,
    "a,aa": true,
    "aa,a": false,
    "a,abc": true,
    "b,abc": true,
    "c,abc": true
]

for test in substringTests {
    let components = test.0.split(separator: ",").map { String($0) }
    let result = components[0].isSubstring(of: components[1]) == test.1
    print("test that \(components[0]) is a substring of \(components[1]): \(result ? "passed" : "failed")")
}

let rotationTests: [String: Bool] = [
    "waterbottle,erbottlewat": true
]

for test in rotationTests {
    let components = test.0.split(separator: ",").map { String($0) }
    let result = components[0].isRotation(of: components[1]) == test.1
    print("test that \(components[0]) is a rotation of \(components[1]): \(result ? "passed" : "failed")")
}

//: [Next](@next)
