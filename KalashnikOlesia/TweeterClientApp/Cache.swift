//
//  Cache.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/16/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import Foundation

class Cache<T: Hashable> {
    private var database : [String: T]     //dict -- URL : Tada
    private var transactions : [String]     // stack of most recent urls
    private let size : Int
    
    required init(size: Int) {
        self.database = Dictionary(minimumCapacity: size)
        self.transactions = [String]()
        self.size = size
    }
    
    func write(data: T, key: String) {
        if self.transactions.count < self.size {
            //append to the end
            self.database[key] = data
            self.transactions.append(key)
            
        } else {
            // replace the oldest data
            let top = self.transactions.removeFirst()
            self.database.removeValueForKey(top)
            write(data, key: key)
            
        }
    }
    
    func read(key:String) -> T? { //O(n) - TODO: O(1)
        if let data = self.database[key], index = self.transactions.indexOf(key) {
            self.transactions.append(self.transactions.removeAtIndex(index))
            return data
        }
        return nil
    }
}