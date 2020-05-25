//
//  TableViewCell.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 24/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import UIKit
import WebKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
