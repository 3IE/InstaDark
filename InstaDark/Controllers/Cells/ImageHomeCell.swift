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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(media: ImageMedia) {
        self.imageUsername.text = media.user?.name ?? ""
        self.imageUsernameDescription.text = media.user?.location ?? ""
        self.imageMedia.image = nil
        self.profileImage.image = nil
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.likesLabel.text = "\(media.likes ?? 0) likes"
        self.DescriptionTV.text = "@\(media.user?.username ?? "") \(media.description != nil ? "\n" : "") \(media.description ?? "")"
        Alamofire.request(media.imageUrl ?? "").responseImage { response in
            if let image = response.result.value {
                self.imageMedia.image = image
            }
        }
        
        ImageBusiness.getImageFrom(path: media.user?.profileImgUrl ?? "") { (image) in
                self.profileImage.image = image
            
        }
        ImageBusiness.getImageFrom(path: media.imageUrl ?? "") { (image) in
            self.imageMedia.image = image
        }
        
    }

}
