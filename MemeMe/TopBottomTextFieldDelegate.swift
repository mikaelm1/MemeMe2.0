//
//  TopBottomTextFieldDelegate.swift
//  MemeMe
//
//  Created by Mikael Mukhsikaroyan on 2/6/16.
//  Copyright © 2016 msquared. All rights reserved.
//

import UIKit

class TopBottomTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var topTextField: UITextField!
    var bottomTextField: UITextField!
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -4.0
    ]
    
    func setupTextFields() {
        let textFields = [topTextField, bottomTextField]
        for field in textFields {
            field.delegate = self
            field.defaultTextAttributes = memeTextAttributes
            field.borderStyle = .None
            field.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            field.textAlignment = .Center
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
}
