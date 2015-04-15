//
//  FileUploadView.swift
//  FileUpload
//
//  Created by Frank Tisellano on 4/14/15.
//  Copyright (c) 2015 Frank Tisellano. All rights reserved.
//

import Cocoa
import Foundation
import SwiftHTTP

class FileUploadView : NSView {
     override init(frame: NSRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        let types = [NSFilenamesPboardType, NSURLPboardType]
        registerForDraggedTypes(types)
        println(self.registeredDraggedTypes)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        NSColor.purpleColor().set()
        NSBezierPath.fillRect(self.bounds)
    }
    
    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation {
        println("draggingEntered: \(sender)")
        return NSDragOperation.Copy
    }
    
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        println("draggingPerformed: \(sender)")

        let pboard = sender.draggingPasteboard()
        let uploadLocation = "http://localhost:3000/file_uploads.json"
        let fileUrl = NSURL(fromPasteboard: pboard)
        
        println(fileUrl)
        
        var request = HTTPTask()
        request.POST(
            uploadLocation,
            parameters:  ["file_upload": ["raw_file": HTTPUpload(fileUrl: fileUrl!)]],
            success: {(response: HTTPResponse) in
                
                let un = UserNotification()
                un.showNotification(
                    "File Uploaded",
                    notificationInfoText: "So awesome!" // todo: put some more descriptive text here and copy URL to clipboard
                )
                
                if let data = response.responseObject as? NSData {
                    let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("response: \(str)") //prints the HTML of the page
                }
            },failure: {(error: NSError, response: HTTPResponse?) in
                let un = UserNotification()
                un.showNotification(
                    "Error",
                    notificationInfoText: "Could not upload file." // todo: log this error
                )
        })
        return true
    }
}