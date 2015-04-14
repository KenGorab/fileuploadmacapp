//
//  ViewController.swift
//  FileUpload
//
//  Created by Frank Tisellano on 4/14/15.
//  Copyright (c) 2015 Frank Tisellano. All rights reserved.
//

import Cocoa
import Alamofire

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
        
    @IBAction func getUploads(sender: AnyObject) {
        Alamofire.request(.GET, "http://localhost:3000/file_uploads.json")
            .responseJSON { (request, response, data, error) in
                println("Request: \(request)")
                println("Response: \(data)")
        }
    }


}

