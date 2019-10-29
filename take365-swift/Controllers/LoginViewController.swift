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
        
//        btnSignIn.layer.borderWidth = 1.0
//        btnSignIn.layer.borderColor = btnSignIn.tintColor.cgColor
//        btnSignIn.layer.cornerRadius = 5.0
//        btnSignIn.clipsToBounds = true
//        btnSignIn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//        btnSignIn.setTitleColor(btnSignIn.tintColor, for: UIControlState.normal)
//        btnSignIn.setTitleColor(UIColor.white, for: UIControlState.highlighted)
//        btnSignIn.setBackgroundImage(UIImage.imageFromColor(btnSignIn.tintColor), for: UIControlState.highlighted)
    }

    @IBAction func btnLoginClicked(_ sender: UIButton) {
        if(tvLogin.text != nil && !tvLogin.text!.isEmpty && tfPassword.text != nil && !tfPassword.text!.isEmpty) {
            Take365Api.instance.login(userName: tvLogin.text!, password: tfPassword.text!, success: { (response: LoginResponse) in
                print("success")
                print(response)
            }) { errors in
                print("failed")
            }
        }
    
    }
}
