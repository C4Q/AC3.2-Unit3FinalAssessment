//
//  DetailViewController.swift
//  Unit3FinalAssessment
//
//  Created by C4Q on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var object: MuseumObject?
    

    
    @IBOutlet weak var objectImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = object?.title
        self.objectImage.image = #imageLiteral(resourceName: "default-placeholder")
        self.descriptionLabel.text = object?.description
        
        guard let validObject = object else {return}
        
        APIManager.manager.getData(endPoint: validObject.image) { (data: Data?) in
            if let d = data {
                print(d)
                self.objectImage.image = UIImage(data: d)
            }
            DispatchQueue.main.async {
                self.objectImage.reloadInputViews()
            }
        }
        APIManager.manager.getData(endPoint: validObject.description) { (data: Data?) in
            if let d = data {
                if let des = Description.getDescription(data: d) {
                   self.descriptionLabel.text = des.decription
                }
            }
        }
    }
}
