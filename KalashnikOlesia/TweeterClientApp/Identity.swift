//
//  Identity.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/15/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import Foundation

protocol Identity {
    static func id() -> String
}

extension Identity {
    static func id() -> String {
        return String(Self)
    }
}
