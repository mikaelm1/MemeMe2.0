//
//  MemeEditorVC.swift
//  MemeMe
//
//  Created by Mikael Mukhsikaroyan on 1/31/16.
//  Copyright © 2016 msquared. All rights reserved.
//

import UIKit

class MemeEditorVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var chosenImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var meme: Meme?
    var topBottomTextDelegate = TopBottomTextFieldDelegate()
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -4.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = topBottomTextDelegate
        bottomTextField.delegate = topBottomTextDelegate
        setupTextFields()
        shareButton.enabled = false
        title = "Editor"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
        navigationController?.navigationBarHidden = true
        tabBarController?.tabBar.hidden = true
        
        checkForMeme()
    }
    
    override func viewWillDisappear(animated: Bool) {
        unsubscribeFromKeyboardNotifications()
        navigationController?.navigationBarHidden = false
        tabBarController?.tabBar.hidden = false
    }
    
    func checkForMeme() {
        if meme != nil {
            chosenImage.image = meme?.originalImage
            bottomTextField.text = meme?.bottomText
            topTextField.text = meme?.topText
            shareButton.enabled = true
        }
    }
    
    func setupTextFields() {
        let textFields = [topTextField, bottomTextField]
        for field in textFields {
            field.defaultTextAttributes = memeTextAttributes
            field.borderStyle = .None
            field.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            field.textAlignment = .Center
        }
    }
    
    // MARK: Keyboard methods
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = getKeyboardHeight(notification) * -1
        }
    }
    
    func keyboardWillHide() {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = 0
        }
        
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // MARK: ImagePicker methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            chosenImage.image = image
            shareButton.enabled = true
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func pickImageFrom(source: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveImage() {
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: chosenImage.image!, memedImage: memedImage)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        navigationBar.hidden = true
        toolBar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navigationBar.hidden = false
        toolBar.hidden = false
        
        return memedImage
    }
    
    // MARK: Actions
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        pickImageFrom(.PhotoLibrary)
    }
    
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        pickImageFrom(.Camera)
    }
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        presentViewController(controller, animated: true, completion: nil)
        
        controller.completionWithItemsHandler = { (type, completed, items, error) in
            if completed {
                print("Saving image")
                self.saveImage()
                self.navigationController?.popViewControllerAnimated(true)
            }
            
        }
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        chosenImage.image = nil
        navigationController?.popViewControllerAnimated(true)
    }
    
    
}
