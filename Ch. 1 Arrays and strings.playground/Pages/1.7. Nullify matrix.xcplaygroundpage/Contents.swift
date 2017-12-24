//: [Previous](@previous)

/*
 * Write an algorithm such that if an element in an MxN matrix is 0,
 * its entire row and column are set to 0.
 */

import Foundation

func nullify(_ array: inout [[Int]]) {
    print("nullify array \(array)")
    let length = array.count
    
    //  Make sure that the array is indeed an NxN matrix
    for row in array {
        guard row.count == length else {
            print("not NxN")
            return
        }
    }
    
    var rowsToReplaceWithZeroes = Set<Int>()
    var columnsToReplaceWithZeroes = Set<Int>()
    
    for (i, row) in array.enumerated() {
        for (j, element) in row.enumerated() {
            if element == 0 {
                rowsToReplaceWithZeroes.insert(i)
                columnsToReplaceWithZeroes.insert(j)
            }
        }
    }
    
    for i in rowsToReplaceWithZeroes {
        for j in 0..<length {
            array[i][j] = 0
        }
    }
    
    for j in columnsToReplaceWithZeroes {
        for i in 0..<length {
            array[i][j] = 0
        }
    }
    
    print("result: \(array)")
}

var array = [[1,2,3],[4,5,6],[7,8,9]]
nullify(&array)

array = [[1,0,3],[4,5,6],[7,8,9]]
nullify(&array)

//: [Next](@next)
