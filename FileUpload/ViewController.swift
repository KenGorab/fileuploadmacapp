//
//  ViewController.swift
//  FileUpload
//
//  Created by Frank Tisellano on 4/14/15.
//  Copyright (c) 2015 Frank Tisellano. All rights reserved.
//

import Cocoa
import SwiftHTTP

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
  
    @IBOutlet var preferencesMenu: NSMenu!
    @IBOutlet weak var fileTableView: NSTableView!
    
    var files: Array<FileModel>?
    let fileService = FileService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fileTableView.setDataSource(self)
        self.fileTableView.setDelegate(self)
        
        let nib = NSNib(nibNamed: "FTCellView", bundle: NSBundle.mainBundle())
        fileTableView.registerNib(nib!, forIdentifier: "FTCellView")
        
        fileService.getFiles({ files in
            self.files = files
            self.fileTableView.reloadData()
        })
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        switch (self.files) {
        case .Some(let files): return files.count
        case .None: return 0
        }
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeViewWithIdentifier("FTCellView", owner: self) as! FTCellView
        switch (self.files) {
        case .Some(let files) where files.count >= row: cell.originalFilename.stringValue = files[row].slug!
        case _: break
        }
        return cell
    }
    
    @IBAction func refreshData(sender: AnyObject) {

    }

    @IBAction func toggleMenu(sender: AnyObject) {
        
    }
}

