//Week 2 Day 1 Assignment Code Challenge

import UIKit

//Write a function that reverses an array

var appleHardware = ["iPhone", "iPad", "iPod", "MacBook", "Apple Watch", "Apple TV"]
//Result of array needs to look like: ["Apple TV", "Apple Watch", "MacBook", "iPod", "iPad", "iPhone"]


func reverseArray(inputArray: [String]) -> [String] {
    //Initialize an empty array of strings
    var outputArray = [String]()
    
    //Loop through the array of strings
    for item in inputArray.count.predecessor().stride(through: 0, by: -1) {
        outputArray.append(inputArray[item])
    }
    //Return the completed array
    return outputArray
}

//Testing the function reverseArray by passing in the appleHardware array of strings
reverseArray(appleHardware)


