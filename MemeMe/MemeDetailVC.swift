//
//  MemeDetailVC.swift
//  MemeMe
//
//  Created by Mikael Mukhsikaroyan on 1/31/16.
//  Copyright © 2016 msquared. All rights reserved.
//

import UIKit

class MemeDetailVC: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImage.image = meme?.memedImage
        navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editImage"), animated: true)
        title = "Detail"

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
        if identifier == "editMeme" {
            let editorVC = storyboard?.instantiateViewControllerWithIdentifier("EditorVC") as! MemeEditorVC
            editorVC.chosenImage.image = meme?.memedImage
        }
    }
    
    func editImage() {
        let editorVC = storyboard?.instantiateViewControllerWithIdentifier("EditorVC") as! MemeEditorVC
        editorVC.meme = meme
        navigationController?.pushViewController(editorVC, animated: true)
    }
    


}
