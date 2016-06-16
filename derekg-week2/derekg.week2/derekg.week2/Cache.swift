//
//  Cache.swift
//  derekg.week2
//
//  Created by Derek Graham on 6/16/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
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
    
    func write( data: T, key: String)
    {
        if self.transactions.count < self.size {
            
            self.database[key] = data
            self.transactions.append(key)
            
        } else {
            
            let top = self.transactions.removeFirst()
            self.database.removeValueForKey(top)
            
            // transactions and database now size -1
            
            self.write(data, key: key)
        }
    }
    
    
    func read(key: String) -> T?
    {
        if let data = self.database[key], index = self.transactions.indexOf(key)
        {
            self.transactions.append(self.transactions.removeAtIndex(index))
            return data
        }
        
        return nil
    }
}