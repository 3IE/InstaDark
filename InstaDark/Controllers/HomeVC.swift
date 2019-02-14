//
//  HomeVC.swift
//  InstaDark
//
//  Created by Yassir Ramdani on 12/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import UIKit

class HomeVC: UITableViewController {
    
    var feedList = [ImageMediaResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "InstagramLogo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        getData()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func getData(fromPage page: Int = 0) {
        ImageMediaBusiness.getDataForPage(page) { (imageMediaList) in
            imageMediaList?.forEach({ (imageMedia) in
                self.feedList.append(imageMedia)
            })
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedList.count + 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PresentStory" {
            let storyPresenter = segue.destination as! StoriesVC
            let collectionView = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? StoriesCollectionCell)?.collectionView
            let indexPath = collectionView?.indexPath(for: sender as! StorieCell)
            
            storyPresenter.setUpStory(user: self.feedList[indexPath?.item ?? 0].user)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "storiesCollectionCell", for: indexPath) as! StoriesCollectionCell
            var users = [UserResponse]()
            feedList.forEach { (mediaImage) in
                users.append(mediaImage.user!)
            }
            cell.setStories(users)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! ImageHomeCell
        cell.setupCell(media: feedList[indexPath.row])
        if indexPath.row == feedList.count - 3 {
            // Adds next page images to feedList
            getData(fromPage:feedList.count / 30 + 1)
        }
        return cell
    }
    
}
