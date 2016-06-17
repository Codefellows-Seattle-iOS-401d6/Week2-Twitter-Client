//
//  AppDelegate.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/13/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // create instance of cache. Will be used throughout the app for fetching images
    var cache = Cache<UIImage>(size: 100)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
}

