//
//  BtnLikeState.swift
//  InstaDark
//
//  Created by Yassir Ramdani on 14/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import Foundation

enum LikeState: String {
    case like
    case liked
    mutating func switchLike() {
        if self == .like {
            self = .liked
        } else {
            self = .like
        }
    }
}
