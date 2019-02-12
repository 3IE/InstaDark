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

private enum Router {
    case page(Int)
}

//MARK: - RouterProtocol

extension Router: RouterProtocol {
    var method: HTTPMethod {
        switch self {
        case .page:
            return .get
        }
    }
    var path: String {
        switch self {
        case .page(let page):
            debugPrint("GET : \(Bundle.apiBaseUrl)/photos/?page=\(page)&per_page=30&client_id=\(Bundle.apiKey)")
            return "\(Bundle.apiBaseUrl)/photos/?page=\(page)&per_page=30&client_id=\(Bundle.apiKey)"
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
    static func getImageMediaPage(page: Int, completed: @escaping (_ response: [ImageMedia]?) -> Void) {
        Alamofire.request(Router.page(page)).responseArray(completionHandler: { (resp: DataResponse<[ImageMedia]>) in
          completed(resp.result.value)
        })
    }
}
