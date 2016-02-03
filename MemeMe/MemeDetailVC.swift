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
    
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        detailImage.image = meme?.memedImage

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    


}
