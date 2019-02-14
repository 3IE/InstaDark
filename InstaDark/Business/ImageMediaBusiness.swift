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
    static func getDataForPage(_ page: Int, completed: @escaping ([ImageMediaResponse]?) -> Void) {
        ImageMediaData.getDataForPage(page: page) { (medias) in
            completed(medias)
        }
    }
}

class ImageBusiness {
    static func getImageFromUrl(_ url: String, completed: @escaping (UIImage) -> Void) {
        ImageData.getImageFromUrl(url) { (image) in
            completed(image)
        }
    }
}
