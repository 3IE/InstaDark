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
        
        GetData()
    }
    
    func GetData(fromPage page: Int = 0){
        
        ImageMediaBusiness.getImageMediaPage(page) { (imageMediaList) in
            imageMediaList?.forEach({ (imageMedia) in
                self.feedList.append(imageMedia)
            })
            self.tableView.reloadData()
        }

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! ImageHomeCell
        cell.setupCell(media: feedList[indexPath.row])
        if indexPath.row == feedList.count - 3 {
            // Adds next page images to feedList
            GetData(fromPage:feedList.count / 30 + 1)
        }
        return cell
    }
    
}
