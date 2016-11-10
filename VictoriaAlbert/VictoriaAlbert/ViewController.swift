//
//  ViewController.swift
//  VictoriaAlbert
//
//  Created by Thinley Dorjee on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var homeLabel: UILabel!
    var imageEndPoint = "http://media.vam.ac.uk/media/thira/collection_images/2006AM/2006AM6763.jpg"
    
    var detailRing: Ring?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = detailRing?.place
        homeLabel.text = detailRing?.object
        
        APIRequestManager.manager.downloadImage(urlString: imageEndPoint) { (data) in
            DispatchQueue.main.async {
                self.detailImage.image = UIImage(data: data)
                
            }
        }
        
    }
}

