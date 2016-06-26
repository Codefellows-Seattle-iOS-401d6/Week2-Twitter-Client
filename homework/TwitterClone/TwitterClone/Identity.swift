//
//  Identity.swift
//  TwitterClone
//
//  Created by Sung Kim on 6/15/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
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