//
//  ImageMedia.swift
//  InstaDark
//
//  Created by Yassir Ramdani on 12/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import Foundation
import ObjectMapper

struct ImageMediaResponse {
    var id:String?
    var width:Int?
    var height:Int?
    var imageUrl:String?
    var user:User?
    var descriptionImage:String?
    var likes:Int?
}

extension ImageMediaResponse: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        width <- map["width"]
        height <- map["height"]
        imageUrl <- map["urls.small"]
        user <- map["user"]
        descriptionImage <- map["description"]
        likes <- map["likes"]
    }
}
