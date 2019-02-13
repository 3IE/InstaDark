//
//  ImageMediaBusiness.swift
//  InstaDark
//
//  Created by Yassir Ramdani on 13/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import Foundation
import UIKit

class ImageMediaBusiness {
    static func getImageMediaPage(_ page: Int, completed: @escaping ([ImageMediaResponse]?) -> Void) {
        ImageMediaData.getImageMediaPage(page: page) { (medias) in
            completed(medias)
        }
    }
}

class ImageBusiness {
    static func getImageFrom(path: String, completed: @escaping (UIImage) -> Void) {
        ImageData.getImageFrom(path: path) { (image) in
            completed(image)
        }
    }
}
