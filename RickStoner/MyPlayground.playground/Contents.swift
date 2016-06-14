//: Playground - noun: a place where people can play

import UIKit

func reverse<T>(array: [T]) -> [T] {
    var reversedArray = [T]()
    
    for index in 0..<array.count {
        reversedArray.insert(array[index], atIndex: reversedArray.startIndex)
    }
    return reversedArray
}
// just created the function for now. I assume I'll be inputting in a class or implementing it in the app later this week
let testString = ["These", "words", "should", "be", "reversed"]
let reversedtestString = reverse(testString)
