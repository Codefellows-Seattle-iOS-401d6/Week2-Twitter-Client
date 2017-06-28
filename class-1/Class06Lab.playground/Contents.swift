//: Playground - noun: a place where people can play

import UIKit

let test = [0,1,2,3,4,5,6,7,8,9]

func reverseArray<T> (input: [T]) -> [T] {
    var result = [T]()
    for item in input {
    result.insert(item, atIndex: 0)
    }
    return result
 }

reverseArray(test)

func reverseArrayTwo<T> (input: [T]) -> [T] {
    var result = [T]()
    result = input.reverse().map({$0})
    
    return result
}

reverseArrayTwo(test)
