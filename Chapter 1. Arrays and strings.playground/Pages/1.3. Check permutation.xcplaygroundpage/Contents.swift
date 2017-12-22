//: [Previous](@previous)

/* 1.3.
 * Given two strings, write a method to decide if one is a permutation of the other.
 */

import Foundation

extension String {
    func isPermutation(of other: String) -> Bool {
        let dict1 = self.asDict
        let dict2 = other.asDict
        return dict1 == dict2
    }
    
    private var asDict: [Character: Int] {
        var result = [Character: Int]()
        
        for character in self {
            result[character] = (result[character] ?? 0) + 1
        }
        
        return result
    }
}

let tests: [String: Bool] = [
    ",": true,
    "a,a": true,
    "a,b": false,
    "ab,ba": true,
    "aaa,aaa": true,
    "aaa,aaaa": false,
    "a space , a space": true
]

for test in tests {
    var components = test.0.split(separator: ",").map { String($0) }
    if components.count == 0 {
        components.append("")
        components.append("")
    }
    let result = components[0].isPermutation(of: components[1]) == test.1
    print("test that \(components[0]) is a permutation of \(components[1]): \(result ? "passed" : "failed")")
}


//: [Next](@next)
