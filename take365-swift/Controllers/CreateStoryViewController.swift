//
//  CreateStoryViewController.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 30.10.2019.
//  Copyright © 2019 Evgeniy Eliseev. All rights reserved.
//

import Foundation
import UIKit

class CreateStoryViewController: UITableViewController {
    @IBOutlet var tfTitle: UITextField?
    @IBOutlet var tfDescription: UITextField?
    @IBOutlet var scPrivacyLevel: UISegmentedControl?
    
    @IBAction func privacyValueChanged(_ sender: Any) {
        
    }
}
