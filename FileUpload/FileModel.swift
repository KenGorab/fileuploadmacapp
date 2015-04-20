//
//  FileModel.swift
//  FileUpload
//
//  Created by Frank Tisellano on 4/18/15.
//  Copyright (c) 2015 Frank Tisellano. All rights reserved.
//

import Cocoa

struct FileModel {
    var id: Int?
    var original_filename: String?
    var aws_url: String?
//    var uuid: String?
    var slug: String?
    var url: String?
    
    init() {
        
    }
    
    init(id: Int, original_filename: String, aws_url: String, slug: String, url: String) {
        self.id = id
        self.original_filename = original_filename
        self.aws_url = aws_url
//        self.uuid = uuid
        self.slug = slug
        self.url = url
    }
}