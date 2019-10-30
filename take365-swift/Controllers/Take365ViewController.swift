//
//  Take365ViewController.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 07/03/2018.
//  Copyright © 2018 Evgeniy Eliseev. All rights reserved.
//

import Foundation
import UIKit

class Take365ViewController: UIViewController {
    
    let maTextFields = NSMutableArray()
    var currentMovement: CGFloat = 0
    
    override func viewDidLoad() {
        Take365Api.instance.onInvalidAccessToken = {
            UserDefaults.standard.removeObject(forKey: "accessToken")
            UserDefaults.standard.synchronize()
            
            let loginController = self.storyboard!.instantiateViewController(withIdentifier: "login")
            self.present(loginController, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let properties = Mirror(reflecting: self).children.compactMap { $0 }
        for prop in properties {
            if(prop.value is UITextField) {
                let tf = prop.value as! UITextField
                applyBorderLessStyle(tf: tf, color: UIColor.black)
                tf.delegate = self
                maTextFields.add(tf)
                tf.addTarget(self, action: #selector(self.textFieldDidChanged(_:)), for: UIControl.Event.editingChanged)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    
    func dismissKeyboard() {
        for tf in maTextFields {
            (tf as! UITextField).endEditing(true)
        }
    }
    
    func moveUpViewForKeyboard(tf: UITextField) {
        let ypos = tf.convert(tf.frame.origin, to: nil).y
        let delta = self.view.frame.size.height + 35 - tf.frame.size.height*2 - ypos
        
        if(delta < 0) {
            currentMovement = -delta
        } else {
            currentMovement = 0
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.bounds = self.view.bounds.offsetBy(dx: 0, dy: self.currentMovement)
        }
    }
    
    func moveViewDown() {
        if(currentMovement > 0) {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.bounds = self.view.bounds.offsetBy(dx: 0, dy: -self.currentMovement)
            })
        }
    }
    
    func applyBorderLessStyle(tf: UITextField, color:UIColor) -> Void {
        let bottomBorder = CALayer.init()
        bottomBorder.frame = CGRect.init(x: 0.0, y: tf.frame.size.height - 1, width: tf.frame.size.width, height: 1.0)
        bottomBorder.backgroundColor = color.cgColor
        tf.layer.addSublayer(bottomBorder)
    }
}

extension Take365ViewController: UITextFieldDelegate {
    @objc func textFieldDidChanged(_ textField: UITextField) {
        clearButtonAdjustmentWith(textField)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        clearButtonAdjustmentWith(textField)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearButtonAdjustmentWith(textField)
        applyBorderLessStyle(tf: textField, color: UIColor.red)
        moveUpViewForKeyboard(tf: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        clearButtonAdjustmentWith(textField)
        applyBorderLessStyle(tf: textField, color: UIColor.black)
        moveViewDown()
    }
    
    private func clearButtonAdjustmentWith(_ textField: UITextField) {
        guard textField.textContentType == UITextContentType.password else {
            return
        }
        
        guard let text = textField.text else {
            return
        }
        
        if text.count == 0 {
            textField.clearButtonMode = UITextField.ViewMode.never
        } else {
            textField.clearButtonMode = UITextField.ViewMode.always
        }
    }
}

