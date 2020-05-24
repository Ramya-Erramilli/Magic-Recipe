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
//    @IBOutlet weak var imageViewOutlet: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func loadImage(fromURL:String){
//    if let url = URL(string: fromURL){
//        let request = URLRequest(url: url)
//        imageViewOutlet.load(request)
//    }
//        
//    }

}
