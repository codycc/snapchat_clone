//
//  RoundTextField.swift
//  devchatClone
//
//  Created by Cody Condon on 2016-10-17.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation
import UIKit

// seetting up for interface building
@IBDesignable
class RoundTextField: UITextField {
    // corner radius set in interface builder
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            // cut out anything past what the corner radius states
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }
    
    @IBInspectable var placeholderColor: UIColor? {
        didSet {
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: rawString , attributes: [NSForegroundColorAttributeName: placeholderColor!])
            attributedPlaceholder = str
        }
    }
}
