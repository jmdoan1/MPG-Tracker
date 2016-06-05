//
//  FillupTableViewCell.swift
//  MPG
//
//  Created by Justin Doan on 5/31/16.
//  Copyright © 2016 Justin Doan. All rights reserved.
//

import UIKit

class FillupTableViewCell: UITableViewCell {
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblMPG: UILabel!
    @IBOutlet var lblPriceTotal: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
