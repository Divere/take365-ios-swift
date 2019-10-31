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
    var refreshControl: UIRefreshControl?
    
    var stories: [StoryModel]?
    var selectedStory: StoryModel?

    override func viewDidLoad() {
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.tableFooterView = UIView(frame: CGRect.zero)
        title = "Мои истории"
        navigationController?.navigationBar.tintColor = UIColor.red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(newStory))
        
        refreshControl = UIRefreshControl()
        tableView?.refreshControl = refreshControl
        refreshControl?.addTarget(self, action: #selector(refreshStories), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshStories()
    }
    
    @objc func newStory() {
        self.performSegue(withIdentifier: "SEGUE_CREATE_STORY", sender: self)
    }
    
    @objc func refreshStories() {
        Take365Api.instance.getStoryList(success: { (storyList) in
            self.stories = storyList.result
            self.tableView?.reloadData()
            self.refreshControl?.endRefreshing()
        }) { (error) in
            self.showAlert(title: "Ошибка загрузки историй", message: error!.value!)
            self.refreshControl?.endRefreshing()
        }
    }
}

extension StoriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch true {
        case stories != nil && stories!.count < 1:
            return tableView.dequeueReusableCell(withIdentifier: "CreateNewStoryCell")!
        case stories != nil && stories!.count >= 1:
            let model = stories![indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell") as! StoryCell
            cell.lblStoryName!.text = model.title ?? "Без названия"
            cell.lblCompleted!.text = "\(model.progress.totalImages) из \(model.progress.totalDays) (\(model.progress.percentsComplete)%)"
            if(model.progress.percentsComplete == "100") {
                cell.lblCompleted?.textColor = UIColor.green
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingStoriesCell")!
            cell.backgroundColor = UIColor.clear
            cell.backgroundView = UIView()
            cell.selectedBackgroundView = UIView()
            return cell
        }
    }
    
    
}

extension StoriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
