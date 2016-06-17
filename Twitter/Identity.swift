//
//  Identity.swift
//  TWTR
//
//  Created by Sean Champagne on 6/15/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import Foundation

protocol Identity
{
    static func id() -> String
}

extension Identity
{
    static func id() -> String
    {
        return String(self)
    }
}