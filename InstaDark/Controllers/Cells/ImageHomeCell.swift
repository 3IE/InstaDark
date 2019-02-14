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
    
    enum likeBtnState:String {
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
    
    @IBOutlet weak var likeBtnTop: NSLayoutConstraint!
    @IBOutlet weak var likeBtnLeft: NSLayoutConstraint!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var imageUsernameDescription: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageMedia: UIImageView!
    @IBOutlet weak var imageUsername: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var DescriptionTV: UITextView!
    @IBOutlet weak var likeBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var likeBtnWidth: NSLayoutConstraint!
    var likeBtnStatus: likeBtnState = .like
    
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
        
        likeBtn.imageView?.contentMode = .scaleAspectFit
        likeBtnStatus = .like
        likeBtn.setBackgroundImage(UIImage(named: likeBtnStatus.rawValue), for: .normal)
    }

    @IBAction func didTapLikeBtn(_ sender: Any) {
        self.likeBtnStatus.switchLike()
        likeBtn.setBackgroundImage(UIImage(named: likeBtnStatus.rawValue), for: .normal)
      
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.likeBtnWidth.constant += 4
            self.likeBtnHeight.constant += 4
            self.likeBtnTop.constant -= 2
            self.likeBtnLeft.constant -= 2
            self.layoutIfNeeded()
        }) { (animated) in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.likeBtnWidth.constant -= 4
                self.likeBtnHeight.constant -= 4
                self.likeBtnTop.constant += 2
                self.likeBtnLeft.constant += 2
                self.layoutIfNeeded()
            })
        }
    }
    
}
