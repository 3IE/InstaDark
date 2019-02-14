//
// ImageMediaData.swift
// InstaDark
//
// Created by Yassir Ramdani on 12/02/2019.
//Copyright © 2019 3ie. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import UIKit

private enum Router {
    case getImageMediaPage(Int)
    case getImage(String)
}

//MARK: - RouterProtocol

extension Router: RouterProtocol {
    var method: HTTPMethod {
        switch self {
        case .getImageMediaPage:
            return .get
        case .getImage:
            return .get
        }
        
    }
    var path: String {
        switch self {
        case .getImageMediaPage(let page):
            return "\(Bundle.apiBaseUrl)/photos/?page=\(page)&per_page=30&client_id=\(Bundle.apiKey)&order_by=latest"
        case .getImage(let pathOfImage):
            return pathOfImage
        }
    }
}

//MARK: URLRequestConvertible

extension Router: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let urlRequest = try URLRequest(url: self.path, method: self.method)
        switch self {
        default:
            return urlRequest
        }
    }
}

class ImageMediaData {
    static func getImageMediaPage(page: Int, completed: @escaping (_ response: [ImageMediaResponse]?) -> Void) {
        Alamofire.request(Router.getImageMediaPage(page)).responseArray(completionHandler: { (response: DataResponse<[ImageMediaResponse]>) in
          completed(response.result.value)
        })
    }
}

class ImageData {
    static func getImageFrom(path: String, completed: @escaping (_ response: UIImage) -> Void ) {
        Alamofire.request(Router.getImage(path)).responseImage { response in
            if let image = response.result.value {
                completed(image)
            }
        }
    }
}
