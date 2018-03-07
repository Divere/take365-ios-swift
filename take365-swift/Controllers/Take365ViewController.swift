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
    
    var maTextFields: NSMutableArray?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let properties = Mirror(reflecting: self).children.flatMap { $0 }
        for prop in properties {
            if(prop.value is UITextField) {
                
            }
        }
    }
    
    func applyBorderLessStyle(tf: UITextField, color:UIColor) -> Void {
        let bottomBorder = CALayer.init()
//        bottomBorder.frame = CGRect.init(0.0, tf.frame.size.height - 1, tf.frame.size.width, 1.0)
//        bottomBorder.backgroundColor = color.cgColor
    }
}
