//
//  FileService.swift
//  FileUpload
//
//  Created by Ken Gorab on 4/20/15.
//  Copyright (c) 2015 Ken Gorab. All rights reserved.
//

import Cocoa
import SwiftHTTP

class FileService {
    let url = "http://localhost:3000/file_uploads.json"
    
    let failure = { (error: NSError, response: HTTPResponse?) in
        println(response?.responseObject)
    }

    func getFiles(success: (Array<FileModel>) -> Void) {
        let request = HTTPTask()
        request.responseSerializer = JSONResponseSerializer()
        
        request.GET(url, parameters: nil, success: { response in
            if let items = response.responseObject as? Array<Dictionary<String, AnyObject>> {
                let files: Array<FileModel> = items.map { item in
                    let id = item["id"] as? Int
                    return FileModel(
                        id: item["id"] as! Int,
                        originalFilename: item["original_filename"] as! String,
                        awsUrl: item["aws_url"] as! String,
                        slug: item["slug"] as! String,
                        url: item["url"] as! String
                    )
                }
                success(files)
            }
        }, failure: failure)
    }
}