//
//  Album.swift
//  CollectionDemo
//
//  Created by Ganesh Potnuru on 8/8/17.
//  Copyright © 2017 Ganesh Potnuru. All rights reserved.
//

import Foundation

class Album {
    var id: Int
    var albumId: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    
    init(with json: JSON) {
        id = json["id"].intValue
        albumId = json["albumId"].intValue
        title = json["title"].stringValue
        url = json["url"].stringValue
        thumbnailUrl = json["thumbnailUrl"].stringValue
    }
}
