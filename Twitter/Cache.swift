//
//  Cache.swift
//  TWTR
//
//  Created by Sean Champagne on 6/16/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import Foundation

class Cache<T: Hashable>
{
    private var database: [String: T]
    private var transactions: [String]
    private let size: Int
    
    required init(size: Int)
    {
        self.database = Dictionary(minimumCapacity: size)
        self.transactions = [String]()
        self.size = size
    }
    
    func write(data: T, key: String)
    {
        if self.transactions.count < self.size {
            self.database[key] = data
            self.transactions.append(key)
        } else {
            let top = self.transactions.removeFirst()
            self.database.removeValueForKey(top)
            
            //our transactions log wil be size - 1
            //our database will be size -1
            
//            self.database[key] = data
//            self.transactions.append(key)
            self.write(data, key: key) //equal to the 2 previous lines.
        }
    }
    func read(key: String) -> T?
    {
        if let data = self.database[key], index = self.transactions.indexOf(key)
        { //index = self.transactions.indexOf(key) needs to traverse, making this O(n)
            self.transactions.append(self.transactions.removeAtIndex(index))
            return data
        }
        return nil
    }
    
//    func print()
//    {
//        Swift.print(self.transactions)
//    }
}


//let imageOne: NSString = "imageOne"
//let imageTwo: NSString = "imageTwo"
//let imageThree: NSString = "imageThree"
//let imageFour: NSString = "imageFour"
//let cache = Cache<NSData>(size: 3)

//these would only work in playground
//cache.write(imageOne.dataUsingEncoding(NSUTF8StringEncoding)!, key: "imageOne")
//cache.write(imageTwo.dataUsingEncoding(NSUTF8StringEncoding)!, key: "imageTwo")
//cache.write(imageThree.dataUsingEncoding(NSUTF8StringEncoding)!, key: "imageThree")
//cache.write(imageFour.dataUsingEncoding(NSUTF8StringEncoding)!, key: "imageFour")

//cache.print()

