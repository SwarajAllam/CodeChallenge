//
//  ImageSearchViewController.swift
//  CCiOSdemo
//
//  Created by Swaraj Allam on 16/07/22.
//

import UIKit
import SDWebImage
import ProgressHUD


class ImageSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    
    var ImageArray:[String] = []
    var userArray:[String] = []
    var imageTagsArray:[String] = []
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive : Bool = false
    
    var searchStatus = ""
    var key1 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ImageArray.count == 0 || self.searchStatus == "empty"{
            return 1
        }else{
            return ImageArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageSearchTableViewCell", for: indexPath) as! ImageSearchTableViewCell
        if self.searchStatus == "empty"{
            cell.lbl.isHidden = false
            cell.img.isHidden = true
            cell.lbl.text = "Enter text to search..!!!"
        }else if self.searchStatus == "search"{
            cell.lbl.isHidden = true
            cell.img.isHidden = false
        }else{
            cell.lbl.isHidden = false
            cell.img.isHidden = true
        }
        
        if ImageArray.count != 0 {
            cell.img.sd_setImage(with: URL(string: ImageArray[indexPath.row]), placeholderImage: UIImage(named: "placeholder.png"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ImageArray.count == 0{
            print("search")
            
        }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ImageDetailsViewController") as! ImageDetailsViewController
            newViewController.imageURL = ImageArray[indexPath.row]
            newViewController.uploadedBy = userArray[indexPath.row]
            newViewController.imagetags = imageTagsArray[indexPath.row]
            
            self.present(newViewController, animated: true, completion: nil)
        }
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        
        
        
        if searchBar.text == ""{
            searchStatus = "empty"
            apicall()
        }else{
            searchStatus = "search"
            let str = searchBar.text
            let replaced = str!.replacingOccurrences(of: " ", with: "+")
            self.key1 = replaced
            apicall()
        }
        
        
        
    }
    
    func apicall(){
    ProgressHUD.show("Please Wait ...")
        guard let url = URL(string: "https://pixabay.com/api/?key=28607184-07f5343aa2db2405b6e3922fb&q=\(self.key1)&image_type=photo") else { return }
        
        let task = Foundation.URLSession.shared.dataTask(with: url) { [self] data, response, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    
                    if let data1 = json["hits"] as? [[String:Any]] {
                        
                        
                        
                        self.ImageArray = []
                        self.userArray = []
                        self.imageTagsArray = []
                        
                        
                        if data1.count > 0 {
                            
                            
                            
                            for i in data1
                            {
                                
                                self.ImageArray.append(i["largeImageURL"] as! String)
                                self.userArray.append(i["user"] as! String)
                                self.imageTagsArray.append(i["tags"] as! String)
                                
                            }
                            
                        }else{
                            searchStatus = "empty"
                           
                        }
                       
                        
                        DispatchQueue.main.async {
                            ProgressHUD.dismiss()
                            self.tblView.reloadData()
                        }
                        
                        
                    }
                }
                
            } catch let error as NSError {
                
                print("Failed to load: \(error.localizedDescription)")
            }
            print(ImageArray.count)
            
            
            
        }
        
        
        task.resume()
        
        
        
    }
    
    
    
}
