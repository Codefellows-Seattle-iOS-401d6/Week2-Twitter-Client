//
//  Identity.swift
//  TwitterClone
//
//  Created by Jeremy Moore on 6/15/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import Foundation
import UIKit

protocol Identity {
    static func id() -> String
}

extension Identity {
    static func id() -> String {
        return String(self)
    }
}

