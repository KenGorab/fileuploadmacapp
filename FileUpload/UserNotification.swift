//
//  UserNotification.swift
//  FileUpload
//
//  Created by Frank Tisellano on 4/14/15.
//  Copyright (c) 2015 Frank Tisellano. All rights reserved.
//

import Foundation

class UserNotification {

    func showNotification(notificationTitle: String, notificationInfoText: String) -> Void {
        var notification = NSUserNotification()
        
        notification.title = notificationTitle
        notification.informativeText = notificationInfoText
        notification.hasActionButton = true
        notification.actionButtonTitle = "Open"
        
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
    }
    
}
