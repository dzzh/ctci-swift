//: [Previous](@previous)

/* 1.1
 * Implement an algorithm to determine if a string has all unique characters.
 * What if you cannot use additional data structures?
*/

import Foundation

extension String {
    var hasAllUniqueCharacters: Bool {
        guard !isEmpty else {
            // It's actually a funny question, whether an an empty string should return true or false here.
            return true
        }
        
        var characterSet = Set<Character>()
        for character in characters {
            characterSet.insert(character)
        }
        
        return characterSet.count == count
    }
    
    mutating func hasAllUniqueCharactersWithNoDataStructures() -> Bool {
        guard !isEmpty else {
            // It's actually a funny question, whether an empty string should return true or false here.
            return true
        }
        
        self = String(sorted())
        var i = startIndex
        var j = index(after: i)
        while j != endIndex {
            if self[i] == self[j] {
                return false
            }
            i = j
            j = self.index(after: i)
        }
        return true
    }
}

let tests = [
    "": true,
    "a": true,
    "aa":  false,
    "aba": false,
    "abb": false,
    "abc": true,
    "abbc": false
]

for (index, test) in tests.enumerated() {
    var copy = test.0
    let result = copy.hasAllUniqueCharactersWithNoDataStructures()
    print("test \(index): \(result == test.1 ? "passed" : "failed")")
}

//: [Next](@next)
