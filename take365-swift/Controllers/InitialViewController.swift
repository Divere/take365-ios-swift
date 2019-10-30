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
        let accessToken = UserDefaults.standard.object(forKey: "accessToken") as? String
        if(accessToken != nil) {
            Take365Api.instance.login(accessToken: accessToken!, success: { (response: LoginResponse) in
                self.performSegue(withIdentifier: "AUTOLOGIN_COMPLETED", sender:self);
            }) { (error: BaseResponse.Error?) in
                self.performSegue(withIdentifier: "AUTOLOGIN_FAILED", sender: self)
            }
        } else {
            performSegue(withIdentifier: "AUTOLOGIN_FAILED", sender: self)
        }
    }
}
