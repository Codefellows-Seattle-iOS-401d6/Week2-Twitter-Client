//: Playground - noun: a place where people can play

import UIKit

var guitars = ["Fender", "Gibson", "Martin", "Epiphone"]

func reverseArray(arr: Array <String>) -> Array <String>
{
    var counter = arr.count
    print(counter)
    var reversedArr = [String]()
    while counter > 0
    {
        reversedArr.append(_: arr[counter-1])
        counter = counter - 1
    }
    return reversedArr
}

reverseArray(guitars)
