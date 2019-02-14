//
//  StoriesCell.swift
//  InstaDark
//
//  Created by Yassir Ramdani on 14/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import UIKit

class StoriesCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    var users = [UserResponse]()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storieCell", for: indexPath) as! StorieCell
        cell.layer.cornerRadius = 65/2
        cell.clipsToBounds = true
        cell.setUpView(user: users[indexPath.item])
        return cell
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    func setStories(_ recievedUsers:[UserResponse]) {
        self.users = recievedUsers
        collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
