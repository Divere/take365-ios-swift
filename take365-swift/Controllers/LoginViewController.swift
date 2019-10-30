//
//  LoginViewController.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 07/03/2018.
//  Copyright © 2018 Evgeniy Eliseev. All rights reserved.
//

import Foundation
import UIKit
import JVFloatLabeledTextField

class LoginViewController: Take365ViewController {
    @IBOutlet weak var tfLogin: JVFloatLabeledTextField!
    @IBOutlet weak var tfPassword: JVFloatLabeledTextField!
    @IBOutlet weak var swRemember: UISwitch!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    
        tfLogin.floatingLabelFont = UIFont.boldSystemFont(ofSize: 14)
        tfPassword.floatingLabelFont = UIFont.boldSystemFont(ofSize: 14)
    }

    @IBAction func btnLoginClicked(_ sender: UIButton) {
        self.dismissKeyboard()
        
        if(tfLogin.text != nil && !tfLogin.text!.isEmpty && tfPassword.text != nil && !tfPassword.text!.isEmpty) {
            Take365Api.instance.login(userName: tfLogin.text!, password: tfPassword.text!, success: { (response: LoginResponse) in
                UserDefaults.standard.set(response.result!.token, forKey: "accessToken")
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: "SEGUE_LOGIN_COMPLETED", sender: self)
            }) { error in
                self.showAlert(title: "Ошибка входа", message: error!.value!)
            }
        }
    }
}
