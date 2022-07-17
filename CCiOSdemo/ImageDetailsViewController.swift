//
//  ImageDetailsViewController.swift
//  CCiOSdemo
//
//  Created by Swaraj Allam on 16/07/22.
//

import UIKit
import SDWebImage

class ImageDetailsViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var uploadedbyLabel: UILabel!
    @IBOutlet weak var imgtagsLabel: UILabel!
    @IBOutlet weak var imgresolutionLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var imageURL = ""
    var uploadedBy = ""
    var imagetags = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.img.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        self.uploadedbyLabel.text = uploadedBy
        self.imgtagsLabel.text = imagetags
        
        
        let widthInPixels = img.frame.width * UIScreen.main.scale
        let heightInPixels = img.frame.height * UIScreen.main.scale
        
        self.imgresolutionLabel.text = "\(widthInPixels)x\(heightInPixels) pixels"
        
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
   

}
