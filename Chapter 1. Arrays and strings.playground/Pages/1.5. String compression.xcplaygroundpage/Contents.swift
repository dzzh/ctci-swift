//: [Previous](@previous)

/*
 * Implement a method to perform basic string compression using the counts of repeated characters.
 * For example, the string aabcccccaaa would become a2blc5a3.
 * If the "compressed" string would not become smaller than the original string,
 * your method should return the original string.
 */

import Foundation

extension String {
    
    var compressed: String {
        guard !isEmpty else { return self }
        
        var result = ""
        var previousCharacter = self[startIndex]
        var characterCount = 1
        
        for character in self.dropFirst() {
            if character == previousCharacter {
                characterCount += 1
            } else {
                result += "\(previousCharacter)\(characterCount)"
                previousCharacter = character
                characterCount = 1
            }
        }
        
        result += "\(previousCharacter)\(characterCount)"
        
        return result.count < count ? result : self
    }
}

let tests: [String: String] = [
    "": "",
    "a": "a",
    "aa": "aa",
    "aaa": "a3",
    "aaabcddde": "aaabcddde",
    "aaabcdddd": "a3b1c1d4"
]

for test in tests {
    let result = test.0.compressed == test.1
    print("test that compressing \(test.0) gives \(test.1): \(result ? "passed" : "failed")")
}

//: [Next](@next)
