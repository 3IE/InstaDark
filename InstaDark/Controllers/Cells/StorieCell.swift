//
//  StorieCell.swift
//  InstaDark
//
//  Created by Yassir Ramdani on 14/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import UIKit

class StorieCell: UICollectionViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    func getUserProfileImage(user: UserResponse?) {
        self.profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        guard let porfileImageUrl = user?.profileImgUrl else {
            profileImage.image = UIImage(named: "emptyUserImage")
            return
        }
        ImageBusiness.getImageFrom(path: porfileImageUrl) { (profileImage) in
            self.profileImage.image = profileImage
        }
    }
    func setUpView(user:UserResponse?) {
        self.profileImage.layer.cornerRadius = 30
        self.profileImage.clipsToBounds = true
        getUserProfileImage(user: user)
    }
}
