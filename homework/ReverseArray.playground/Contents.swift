//: Playground - noun: a place where people can play

import UIKit

func reverseArray<T> (inout input: [T]) -> [T] {
    if (input.count != 0) {
        var start = input.startIndex
        var end = input.endIndex.predecessor()
        var startElement = input[start]
        var endElement = input[end]
        repeat {
            input[start] = endElement
            input[end] = startElement
            start = start + 1
            end = end - 1
            startElement = input[start]
            endElement = input[end]
        } while (start <= end)
        return input
    } else {
        return input
    }
}

var testArray = ["string", "moon", "stars", "fish"]
var testArray2 = [1, 2, 3, 4, 5]
var testArray3 = [AnyObject]()

reverseArray(&testArray)
reverseArray(&testArray2)
reverseArray(&testArray3)
