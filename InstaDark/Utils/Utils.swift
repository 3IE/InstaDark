//
//  Utils.swift
//  InstaDark
//
//  Created by Yassir Ramdani on 13/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import Foundation

extension ImageMediaResponse {
    func description() -> String {
        return "@\(self.user?.username ?? "") \(self.descriptionImage != nil ? "\n" : "") \(self.descriptionImage ?? "")"
    }
}

