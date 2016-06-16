//
//  Identity.swift
//  derekg.week2
//
//  Created by Derek Graham on 6/15/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
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