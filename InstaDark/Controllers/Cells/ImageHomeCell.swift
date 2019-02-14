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
    
    @IBOutlet weak var BigLikImage: UIImageView!
    @IBOutlet weak var bigLikeHeight: NSLayoutConstraint!
    @IBOutlet weak var bigLikeWidth: NSLayoutConstraint!
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
    
    var likeBtnStatus: LikeState = .like
    
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
        ImageBusiness.getImageFromUrl(porfileImageUrl) { (profileImage) in
            self.profileImage.image = profileImage
        }
    }
    
    func getMediaImage(media: ImageMediaResponse) {
        guard let mediaImageUrl = media.imageUrl else {
            imageMedia.image = UIImage(named: "emptyImage")
            return
        }
        ImageBusiness.getImageFromUrl(mediaImageUrl) { (mediaImage) in
            self.imageMedia.image = mediaImage
        }
    }
    
    func getLikes(media: ImageMediaResponse) -> String {
        guard let likes = media.likes else { return "0 likes" }
        return "\(likes) likes"
    }
    
    func setupCell(media: ImageMediaResponse) {
        self.imageUsername.text = media.user?.name ?? ""
        self.imageUsernameDescription.text = media.user?.location ?? "Photographer"
        
        self.DescriptionTV.text = media.description()
        
        likesLabel.text = getLikes(media: media)
        
        self.imageMedia.image = nil
        getMediaImage(media: media)
        
        self.profileImage.image = nil
        getUserProfileImage(user: media.user)
        
        likeBtn.imageView?.contentMode = .scaleAspectFit
        likeBtnStatus = .like
        likeBtn.setBackgroundImage(UIImage(named: likeBtnStatus.rawValue), for: .normal)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        doubleTap.numberOfTapsRequired = 2
        
        self.imageMedia.addGestureRecognizer(doubleTap)
    }

    @objc func didTapImage(_ sender:Any) {
        self.likeBtnStatus.switchLike()
        likeBtn.setBackgroundImage(UIImage(named: likeBtnStatus.rawValue), for: .normal)
        BigLikImage.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.bigLikeWidth.constant += 40
            self.bigLikeHeight.constant += 40
            self.layoutIfNeeded()
        }) { (animated) in
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.bigLikeWidth.constant -= 40
                self.bigLikeHeight.constant -= 40
                self.layoutIfNeeded()
            }) { (animated) in
                self.BigLikImage.isHidden = true
            }
        }
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
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.likeBtnWidth.constant -= 4
                self.likeBtnHeight.constant -= 4
                self.likeBtnTop.constant += 2
                self.likeBtnLeft.constant += 2
                self.layoutIfNeeded()
            })
        }
    }
}
