//
//  Identity.swift
//  TwitterApp
//
//  Created by Jeffrey Eng on 6/15/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import Foundation

protocol Identity {
    static func id() -> String
}

extension Identity {
    static func id() -> String {
        return String(self)
    }
}