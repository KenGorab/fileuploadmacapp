//
//  FileModel.swift
//  FileUpload
//
//  Created by Frank Tisellano on 4/18/15.
//  Copyright (c) 2015 Frank Tisellano. All rights reserved.
//

import Cocoa

struct FileModel {
    let id: Int?
    let originalFilename: String?
    let awsUrl: String?
    let slug: String?
    let url: String?
    
    init(id: Int, originalFilename: String, awsUrl: String, slug: String, url: String) {
        self.id = id
        self.originalFilename = originalFilename
        self.awsUrl = awsUrl
        self.slug = slug
        self.url = url
    }
}