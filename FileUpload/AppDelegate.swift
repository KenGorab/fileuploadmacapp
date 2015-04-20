//
//  AppDelegate.swift
//  FileUpload
//
//  Created by Frank Tisellano on 4/14/15.
//  Copyright (c) 2015 Frank Tisellano. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {

    private let menuView = MenuView()
    
    // MARK: App
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let stateString: String = "Connected"
        dispatch_async(dispatch_get_main_queue()) {
            self.menuView.menu?.itemAtIndex(0)?.title = stateString
        }
        NSUserNotificationCenter.defaultUserNotificationCenter().delegate = self
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    // Notification center delegate methods
    func userNotificationCenter(center: NSUserNotificationCenter, shouldPresentNotification notification: NSUserNotification) -> Bool {
        return true
    }
    
    func userNotificationCenter(center: NSUserNotificationCenter, didActivateNotification notification: NSUserNotification) {
        println("Should open page here.")
    }


}

