//
//  LoginViewController.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 07/03/2018.
//  Copyright © 2018 Evgeniy Eliseev. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: Take365ViewController {
    @IBOutlet weak var tvLogin: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var swRemember: UISwitch!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
