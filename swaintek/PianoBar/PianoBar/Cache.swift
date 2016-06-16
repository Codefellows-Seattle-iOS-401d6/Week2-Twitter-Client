//
//  Cache.swift
//  PianoBar
//
//  Created by David Swaintek on 6/16/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import Foundation

class Cache<T: Hashable>
{
    private var database: [String : T]
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
            
        }
        
        else {
            
            let top = self.transactions.removeFirst()
            self.database.removeValueForKey(top)
            
//            self.database[key] = data
//            self.transactions.append(key)
            self.write(data, key: key)
            
        }
    }
    func read(key: String) -> T?
    {
        if let data = self.database[key], index = self.transactions.indexOf(key) {
            self.transactions.append(self.transactions.removeAtIndex(index))
            
            return data
        }
        
        return nil
    }
    func print()
    {
        Swift.print(self.transactions)
    }
}

let cache = Cache<NSData>(size: 3)

let imageOne: NSString = "imageOne"
let imageTwo: NSString = "imageTwo"
let imageThree: NSString = "imageThree"
let imageFour: NSString = "imageFour"

cache.write(imageOne.dataUsingEncoding(NSUTF8StringEncoding!, key: "imageOne"))
cache.write(imageTwo.dataUsingEncoding(NSUTF8StringEncoding!, key: "imageTwo"))
cache.write(imageThree.dataUsingEncoding(NSUTF8StringEncoding!, key: "imageThree"))
cache.write(imageOne.dataUsingEncoding(NSUTF8StringEncoding!, key: "imageOne"))


cache.print()




















