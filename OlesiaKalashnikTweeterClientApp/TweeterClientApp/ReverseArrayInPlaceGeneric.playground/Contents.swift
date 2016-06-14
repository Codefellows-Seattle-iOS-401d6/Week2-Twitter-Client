//Generic function that reverses an array in place

func reverseArray<T>(inout array : [T]) -> [T] {
    let arrayLength = array.count
    var indexEnd = arrayLength.predecessor()
    while indexEnd > arrayLength.predecessor()/2 {
        let currEndElement = array[indexEnd]
        array[indexEnd] = array[arrayLength.predecessor()-indexEnd]
        array[arrayLength.predecessor()-indexEnd] = currEndElement
        indexEnd = indexEnd.predecessor()
    }
    return array
}


// Tests
var array1 = ["a", "b", "c"]
var array2 = [0, 1, 2, 3, 4]
var array3 = [Bool]()
var array4 = [0.0, 1.0]

reverseArray(&array1)
reverseArray(&array2)
reverseArray(&array3)
reverseArray(&array4)