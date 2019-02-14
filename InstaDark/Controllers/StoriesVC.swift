//
//  StoriesVC.swift
//  InstaDark
//
//  Created by Yassir Ramdani on 14/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import UIKit

class StoriesVC: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var storyImage: UIImageView!
    
    var storyTimer: Timer?
    var StoryDuration = 4.0
    var userStory: UserResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let slideDown = UIGestureRecognizer(target: self, action: #selector(didFinishPresenting))
        slideDown.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func getUserProfileImage(user: UserResponse?) {
        self.profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        self.profileImage.clipsToBounds = true
        guard let porfileImageUrl = user?.profileImgUrl else {
            profileImage.image = UIImage(named: "emptyUserImage")
            return
        }
        ImageBusiness.getImageFromUrl(porfileImageUrl) { (profileImage) in
            self.profileImage.image = profileImage
        }
    }
    
    func setUpStory(user: UserResponse?) {
        userStory = user
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var progressStory: Float = 0
        storyTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (t) in
            progressStory += Float(Double(t.timeInterval) / self.StoryDuration)
            self.progressView.progress = progressStory
            if progressStory >= 1 { self.didFinishPresenting() }
        })
        
        getUserProfileImage(user: userStory)
        
    }
    
    func didFinishPresenting() {
        self.storyTimer?.invalidate()
        self.dismiss(animated: true) {
            debugPrint("ended presentig Storie")
        }
    }
}
