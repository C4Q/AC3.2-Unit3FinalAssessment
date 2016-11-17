//
//  DetailViewController.swift
//  VictoriaAlbert
//
//  Created by Ilmira Estil on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var detailImgEndpoint = ""
    var detailMuseumField: [Museum]?
   
    @IBOutlet weak var detailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (detailMuseumField?.count)! > 0 {
            APIRequestManager.manager.getData(endPoint: detailImgEndpoint) { (data: Data?) in
                if let validData = data,
                    let image = UIImage(data: validData) {
                    DispatchQueue.main.async {
                        self.detailImage.image = image
                        self.view.reloadInputViews()
                    }
                }
            }
        }

        //detailImage.image = detailMuseumField
    
 
 }

    
 
        

   

}
