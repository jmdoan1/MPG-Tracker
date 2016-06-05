//
//  EditCarTableViewCell.swift
//  MPG
//
//  Created by Justin Doan on 6/2/16.
//  Copyright © 2016 Justin Doan. All rights reserved.
//

import UIKit

class EditCarTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet var lblNickName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
