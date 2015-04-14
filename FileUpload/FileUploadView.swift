//
//  FileUploadView.swift
//  FileUpload
//
//  Created by Frank Tisellano on 4/14/15.
//  Copyright (c) 2015 Frank Tisellano. All rights reserved.
//

import Cocoa
import Foundation

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
        let url = NSURL(fromPasteboard: pboard)
        
        println(url)
        
        // TODO: check if file is of correct type
//        appDelegate.setLocalSourceUrl(NSURL.URLFromPasteboard(pboard))
        
        return true
    }
}