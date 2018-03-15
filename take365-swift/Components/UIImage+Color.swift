//
//  UIImage+Color.swift
//
//  Created by Daniela on 11/6/14
//  The MIT License (MIT)
//
//  Copyright (c) 2015 ustwo™
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

/// Extension of UIImage for methods related to creating images from colors

extension UIImage {
    
    /**
     Creates a UIImage from a UIColor object
     - parameter color: The color to create the image from
     - parameter width: The width of the image to be created (optional). Default value is 1.0
     - parameter height: The height of the image to be created (optional). Default value is 1.0
     - returns: A UIImage of that specified color otherwise nil
     */
    open class func imageFromColor(_ color: UIColor, width: CGFloat = 1.0, height: CGFloat = 1.0) -> UIImage? {
        
        var image: UIImage?
        
        let rect = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        
        UIGraphicsBeginImageContext(rect.size)
        
        if let context: CGContext = UIGraphicsGetCurrentContext() {
            
            context.setFillColor(color.cgColor)
            context.fill(rect)
            
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        return image
    }
}
