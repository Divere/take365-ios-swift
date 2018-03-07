//
//  InitialViewController.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 07/03/2018.
//  Copyright © 2018 Evgeniy Eliseev. All rights reserved.
//

import Foundation
import UIKit

class InitialViewController: Take365ViewController {
    override func viewDidAppear(_ animated: Bool) {
        performSegue(withIdentifier: "AUTOLOGIN_FAILED", sender: self)
    }
}
