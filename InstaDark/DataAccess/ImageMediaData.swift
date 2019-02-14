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
    case getDataForPage(Int)
    case getImageFromUrl(String)
}

//MARK: - RouterProtocol

extension Router: RouterProtocol {
    var method: HTTPMethod {
        switch self {
        case .getDataForPage:
            return .get
        case .getImageFromUrl:
            return .get
        }
        
    }
    var path: String {
        switch self {
        case .getDataForPage(let page):
            return "\(Bundle.apiBaseUrl)/photos/?page=\(page)&per_page=30&client_id=\(Bundle.apiKey)&order_by=latest"
        case .getImageFromUrl(let pathOfImage):
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
    static func getDataForPage(page: Int, completed: @escaping (_ response: [ImageMediaResponse]?) -> Void) {
        Alamofire.request(Router.getDataForPage(page)).responseArray(completionHandler: { (response: DataResponse<[ImageMediaResponse]>) in
          completed(response.result.value)
        })
    }
}

class ImageData {
    static func getImageFromUrl(_ url: String, completed: @escaping (_ response: UIImage) -> Void ) {
        Alamofire.request(Router.getImageFromUrl(url)).responseImage { response in
            if let image = response.result.value {
                completed(image)
            }
        }
    }
}
