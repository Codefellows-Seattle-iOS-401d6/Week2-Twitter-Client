//
//  Identity.swift
//  PianoBar
//
//  Created by David Swaintek on 6/16/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
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