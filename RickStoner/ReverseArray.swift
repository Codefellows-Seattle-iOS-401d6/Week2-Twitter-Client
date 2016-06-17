//
//  ReverseArray.swift
//  TWTR
//
//  Created by Rick  on 6/13/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

func reverse<T>(array: [T]) -> [T] {
    var reversedArray = [T]()
    
    for index in 0..<array.count {
        reversedArray.insert(array[index], atIndex: reversedArray.startIndex)
    }
    return reversedArray
}
// I just created the function for now, but I assume I'll be inputting in a class or implementing it in the app later this week.  Tested out in playground.
let testStringArray = ["These", "words", "should", "be", "reversed"]
let reversedTestString = reverse(testStringArray)
let testIntArray = [5, 7, 2, 1]
let reversedTestInt = reverse(testIntArray)
