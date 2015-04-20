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
    
    var files:Array<FileModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = NSNib(nibNamed: "FTCellView", bundle: NSBundle.mainBundle())
        fileTableView.registerNib(nib!, forIdentifier: "FTCellView")
    }

    override var representedObject: AnyObject? {
        didSet {
            dataFromServer()
        }
    }
    
    @IBAction func refreshData(sender: AnyObject) {
        dataFromServer()
    }

    @IBAction func toggleMenu(sender: AnyObject) {
        
    }
    
    func dataFromServer() {
        println("Getting data...")
        let dataLocation = "http://localhost:3000/file_uploads.json"
        
        var request = HTTPTask()
        request.responseSerializer = JSONResponseSerializer();
        
        request.GET(dataLocation, parameters: nil,
            success: {(response: HTTPResponse) in
                let resp:NSArray = response.responseObject! as! NSArray
                for item in resp {
                    println(item["original_filename"])
                        
                    let fm:FileModel = FileModel(
                        id: item["id"] as! Int,
                        original_filename: item["original_filename"]! as! String,
                        aws_url: item["aws_url"]! as! String,
//                        uuid: item["uuid"]! as! String,
                        slug: item["slug"]! as! String,
                        url: item["url"]! as! String
                    )
                    self.files?.append(fm)
                }
                
                println(self.files?.count)
                
                
            },failure: {(error: NSError, response: HTTPResponse?) in
                println(response?.responseObject)
        })
    }

}

extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return files!.count
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeViewWithIdentifier("FTCellView", owner: self) as! FTCellView
        
        if let f = files {
            println(f[row])
            println(row)
            
//            let str = f[row]["original_filename"]
        }
        
//        cell.originalFilename.stringValue = str as! String
        
        
        return cell
    }
}
