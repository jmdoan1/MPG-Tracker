//
//  FillupDetailTableViewCell.swift
//  MPG
//
//  Created by Justin Doan on 6/1/16.
//  Copyright © 2016 Justin Doan. All rights reserved.
//

import UIKit

class FillupDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblData: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
