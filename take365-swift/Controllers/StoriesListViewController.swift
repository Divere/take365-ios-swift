//
//  StoriesListViewController.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 30.10.2019.
//  Copyright © 2019 Evgeniy Eliseev. All rights reserved.
//

import Foundation
import UIKit

class StoriesListViewController: Take365ViewController {
    @IBOutlet var tableView: UITableView?
    
    var stories: [StoryModel]?
    var selectedStory: StoryModel?

    override func viewDidLoad() {
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.tableFooterView = UIView(frame: CGRect.zero)
        title = "Мои истории"
    
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(newStory))
        
    }
    
    @objc func newStory() {
        self.performSegue(withIdentifier: "SEGUE_CREATE_STORY", sender: self)
    }
}

extension StoriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension StoriesListViewController: UITableViewDelegate {
    
}
