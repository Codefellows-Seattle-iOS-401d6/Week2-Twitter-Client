//: Playground - noun: a place where people can play

import UIKit

//challenge: reverse the order of elements in an array

var myArray = ["Earth", "Fire", "Water", "Air", "Spirit"]
var secondArray = ["Baseball", "Football", "Hockey", "Badminton", "Ultimate Frisbee", "Water Polo", "Basketball"]
//func printTwoIndexes(input: [String])-> [String]{
//    
//    var newArray = input
//    var startIndex = 0
//    var endIndex = newArray.count-1
//    var temp = ""
//    for _ in 0...newArray.count/2 {
//            temp = newArray[startIndex]
//            newArray[startIndex] = newArray[endIndex]
//            newArray[endIndex] = temp
//            startIndex++
//            endIndex--
//    }
//    return(newArray)
//}


//use only generics to accomplish the same task

func printTwoIndexes<T>(input: [T]){
    
    var newArray = input
    var startIndex = 0
    var endIndex = newArray.count-1
    var temp: T
    for _ in 0...newArray.count/2 {
        temp = newArray[startIndex]
        newArray[startIndex] = newArray[endIndex]
        newArray[endIndex] = temp
        startIndex++
        endIndex--
    }
    print(newArray)
}

let intArray = [1,2,3,4,5]
let boolArray = [true, true, true, false, false]

printTwoIndexes(intArray)
printTwoIndexes(boolArray)
printTwoIndexes(myArray)
printTwoIndexes(secondArray)

//best solution I can create is O of n/2


