//
//  MoreViewController.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 30.10.2019.
//  Copyright © 2019 Evgeniy Eliseev. All rights reserved.
//

import Foundation
import UIKit

class MoreViewController: UITableViewController  {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            Take365Api.instance.resetAccessToken()
            UserDefaults.standard.removeObject(forKey: "accessToken")
            UserDefaults.standard.synchronize()
            self.performSegue(withIdentifier: "SEGUE_LOGOUT", sender: self)
        default:
            break
        }
    }
}
