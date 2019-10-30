//
//  UIViewController.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 30.10.2019.
//  Copyright © 2019 Evgeniy Eliseev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static var alertController: UIAlertController? = nil
    
    func showAlert(title: String, message: String) {
        UIViewController.alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "Продолжить", style: UIAlertAction.Style.default) { (action: UIAlertAction) in
            UIViewController.alertController?.dismiss(animated: true, completion: nil)
        }
        UIViewController.alertController?.addAction(defaultAction)
        self.present(UIViewController.alertController!, animated: true, completion: nil)
    }
}
