//
//  ImageMedia.swift
//  InstaDark
//
//  Created by Yassir Ramdani on 12/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import Foundation
import ObjectMapper

struct ImageMedia {
    var id:String?
    var width:Int?
    var height:Int?
    var imageUrl:String?
    var user:User?
    var description:String?
    var likes:Int?
}

extension ImageMedia: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        width <- map["width"]
        height <- map["height"]
        imageUrl <- map["urls.small"]
        user <- map["user"]
        description <- map["description"]
        likes <- map["likes"]
    }
    
    
}
