//
//  ImageHomeCell.swift
//  InstaDark
//
//  Created by Yassir Ramdani on 12/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ImageHomeCell: UITableViewCell {
    
    @IBOutlet weak var imageUsernameDescription: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageMedia: UIImageView!
    @IBOutlet weak var imageUsername: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var DescriptionTV: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
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
    
    func getMediaImage(media: ImageMediaResponse) {
        guard let mediaImageUrl = media.imageUrl else {
            imageMedia.image = UIImage(named: "emptyImage")
            return
        }
        ImageBusiness.getImageFrom(path: mediaImageUrl) { (mediaImage) in
            self.imageMedia.image = mediaImage
        }
    }
    
    func getLikes(media: ImageMediaResponse) -> String {
        guard let likes = media.likes else {
            return "0 likes"
        }
        return "\(likes) likes"
    }
    
    func setupCell(media: ImageMediaResponse) {
        
        self.imageUsername.text = media.user?.name ?? ""
        self.imageUsernameDescription.text = media.user?.location ?? ""
        
        self.DescriptionTV.text = media.description()
        
        likesLabel.text = getLikes(media: media)
        
        self.imageMedia.image = nil
        getMediaImage(media: media)
        
        self.profileImage.image = nil
        getUserProfileImage(user: media.user)
    }

}
