//
//  User.swift
//  InstaDark
//
//  Created by Yassir Ramdani on 12/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    var id:String?
    var name:String?
    var profileImgUrl:String?
    var location:String?
    var username:String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        profileImgUrl <- map["profile_image.medium"]
        location <- map["location"]
        username <- map["username"]
    }
    

}
