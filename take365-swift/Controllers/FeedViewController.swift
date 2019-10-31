//
//  FeedController.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 31.10.2019.
//  Copyright © 2019 Evgeniy Eliseev. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class FeedViewController: UITableViewController {
    
    var feedItems: [FeedItem]?
    
    override func viewDidLoad() {
        self.tableView.rowHeight = UITableView.automaticDimension;
        self.tableView.estimatedRowHeight = 44.0;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Take365Api.instance.getFeed(success: { (response) in
            self.feedItems = response.result.list
            self.tableView.reloadData()
        }) { (error) in
            self.showAlert(title: "Ошибка загрузки ленты", message: error!.value!)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
        
        cell.ivImage.kf.setImage(with: URL(string: feedItems![indexPath.row].thumbLarge.url))
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
}
