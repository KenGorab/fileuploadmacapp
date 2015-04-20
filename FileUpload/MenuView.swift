//
//  MenuView.swift
//  DeckRocket
//
//  Created by JP Simard on 6/14/14.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

import Cocoa
import SwiftHTTP

// FIXME: Use system-defined constant once accessible from Swift.
let NSVariableStatusItemLength: CGFloat = -1

final class MenuView: NSView, NSMenuDelegate {
    private var highlight = false

    private let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)

    // MARK: Initializers

    init() {
        super.init(frame: NSRect(x: 0, y: 0, width: 24, height: 24))
        registerForDraggedTypes([NSFilenamesPboardType])
        statusItem.view = self
        setupMenu()
    }

    required convenience init(coder: NSCoder) {
        self.init()
    }

    // MARK: TableView stuff
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return 10
    }
    
    
    // MARK: Menu

    private func setupMenu() {
        menu = NSMenu()
        menu?.autoenablesItems = false
        menu?.addItemWithTitle("Not Connected", action: nil, keyEquivalent: "")
        menu?.itemAtIndex(0)?.enabled = false
        menu?.addItemWithTitle("Quit DeckRocket", action: "quit", keyEquivalent: "")
        menu?.delegate = self
    }

    override func mouseDown(theEvent: NSEvent) {
        super.mouseDown(theEvent)
        if let menu = menu {
            statusItem.popUpStatusItemMenu(menu)
        }
    }

    func menuWillOpen(menu: NSMenu) {
        highlight = true
        needsDisplay = true
    }

    func menuDidClose(menu: NSMenu) {
        highlight = false
        needsDisplay = true
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        statusItem.drawStatusBarBackgroundInRect(dirtyRect, withHighlight: highlight)
        "🚀".drawInRect(CGRectOffset(dirtyRect, 4, -1), withAttributes: [NSFontAttributeName: NSFont.menuBarFontOfSize(14)])
    }

    // MARK: Dragging

    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation {
        return .Copy
    }

    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        let pboard = sender.draggingPasteboard()
        let uploadLocation = "http://localhost:3000/file_uploads.json"
        let fileUrl = NSURL(fromPasteboard: pboard)
        
        var request = HTTPTask()
        request.responseSerializer = JSONResponseSerializer();
        
        request.POST(
            uploadLocation,
            parameters:  ["file_upload": ["raw_file": HTTPUpload(fileUrl: fileUrl!)]],
            success: {(response: HTTPResponse) in
                if let dict = response.responseObject as? Dictionary<String,AnyObject> {
                    println(dict["original_filename"])
                    for (k, v) in dict {
                        println(k)
                    }
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


    private func validateFile(filePath: NSString) -> Bool {
        let allowedExtensions = [
            // Markdown
            "markdown", "mdown", "mkdn", "md", "mkd", "mdwn", "mdtxt", "mdtext", "text",
            // PDF
            "pdf"
        ]
        return contains(allowedExtensions, filePath.pathExtension.lowercaseString)
    }
}
