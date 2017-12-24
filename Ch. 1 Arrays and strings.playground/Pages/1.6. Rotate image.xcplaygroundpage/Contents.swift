//: [Previous](@previous)

/*
 * Given an image represented by an NxN matrix, where each pixel in the image is 4 bytes,
 * write a method to rotate the image by 90 degrees. Can you do this in place?
 */

import Foundation

enum Direction {
    case left
    case right
}

func rotateInPlace(_ array: inout [[Int]], direction: Direction) {
    print("will rotate \(array) in \(direction) direction")
    let length = array.count
    
    // Check that the array has NxN dimension
    for row in array {
        guard row.count == length else {
            print("not \(length)x\(length)")
            return
        }
    }
    
    // A data structure to track rotated elements
    var flags = [[Bool]]()
    for i in 0..<length {
        flags.append([Bool](repeating: false, count: length))
    }
    
    var original = (row: 0, column: 0)
    var rotated = (row: 0, column: 0)
    var originalElement = array[original.row][original.column]
    
    while true {
        switch direction {
        case .left:
            rotated = (row: length - original.column - 1, column: original.row)
        case .right:
            rotated = (row: original.column, column: length - original.row - 1)
        }
        
        if flags[rotated.row][rotated.column] == true {
            var found = false
            for i in 0..<length {
                if found { break }
                for j in 0..<length {
                    if flags[i][j] == false {
                        original = (row: i, column: j)
                        originalElement = array[original.row][original.column]
                        found = true
                        break
                    }
                }
            }
            if !found {
             break
            }
        } else {
//            print("swap \(original) with \(rotated)")
            let swappedElement = array[rotated.row][rotated.column]
            array[rotated.row][rotated.column] = originalElement
            flags[rotated.row][rotated.column] = true
            originalElement = swappedElement
            original = rotated
        }
    }
    print("result: \(array)")
}

var array = [[1,2,3],[4,5,6],[7,8,9]]
rotateInPlace(&array, direction: .right)

array = [[1,2,3],[4,5,6],[7,8,9]]
rotateInPlace(&array, direction: .left)

array = [[1,2,3],[4,5,6],[7,8]]
rotateInPlace(&array, direction: .left)

//: [Next](@next)
