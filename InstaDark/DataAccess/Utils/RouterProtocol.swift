//
// RouterProtocol.swift
// InstaDark
//
// Created by Yassir Ramdani on 12/02/2019.
//Copyright © 2019 3ie. All rights reserved.
//

import Foundation
import Alamofire

protocol RouterProtocol {
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
}
