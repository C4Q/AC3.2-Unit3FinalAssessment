//
//  DetailViewController.swift
//  VictoriaAlbert
//
//  Created by Madushani Lekam Wasam Liyanage on 11/10/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var museumObjectImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    
    var object: MuseumObject?
    var apiEndPoint: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = object?.objectName
        
        
        
        
        if let imageId = object?.imageString, let locationName =  object?.location{
            
            detailLabel.text = "This object can be found in: " + locationName
            
            if imageId != "" {
                
                let imageIdArray = Array(imageId.characters)
                var yearID = ""
                
                for i in 0...5 {
                    yearID += String(describing: imageIdArray[i])
                }
                
                let imageEndURL = "http://media.vam.ac.uk/media/thira/collection_images/"
                let slash = "/"
                let imageTypeString = ".jpg"
                
                let imageEndPoint = imageEndURL + yearID + slash + imageId + imageTypeString
                
                
                APIRequestManager.manager.getData(endPoint: imageEndPoint ) { (data: Data?) in
                    if  let validData = data,
                        let validImage = UIImage(data: validData) {
                        DispatchQueue.main.async {
                            self.museumObjectImage.image = validImage
                        }
                    }
                }
            }
            else {
                self.museumObjectImage.image = UIImage(named: "noPreview")
            }
        }  
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
