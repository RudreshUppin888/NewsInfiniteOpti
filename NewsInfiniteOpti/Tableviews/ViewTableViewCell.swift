//
//  ViewTableViewCell.swift
//  ImageTask
//
//  Created by Rudresh Uppin on 25/09/20.
//  Copyright © 2020 Rudresh Uppin. All rights reserved.
//

import UIKit

class ViewTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelTime: UILabel!

    @IBOutlet weak var imageShow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
