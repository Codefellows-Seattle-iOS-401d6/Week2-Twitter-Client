//
//  Identity.swift
//  TWTR
//
//  Created by Rick  on 6/15/16.
//  Copyright © 2016 Rick . All rights reserved.
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