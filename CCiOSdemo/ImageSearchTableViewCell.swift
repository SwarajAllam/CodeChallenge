//
//  ImageSearchTableViewCell.swift
//  CCiOSdemo
//
//  Created by Swaraj Allam on 16/07/22.
//

import UIKit

class ImageSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}