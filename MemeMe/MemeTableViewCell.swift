//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Mikael Mukhsikaroyan on 2/2/16.
//  Copyright © 2016 msquared. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
