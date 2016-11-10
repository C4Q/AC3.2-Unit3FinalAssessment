//
//  MuseumObjectDetailViewController.swift
//  VictoriaAlbert
//
//  Created by Sabrina Ip on 11/10/16.
//  Copyright © 2016 Sabrina. All rights reserved.
//

import UIKit

class MuseumObjectDetailViewController: UIViewController {

    @IBOutlet weak var largeImageView: UIImageView!
    
    @IBOutlet weak var imageDetailsTextView: UITextView!
    var individualObject: MuseumObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Object \(individualObject.objectNumber)"
        let largeImageURL = individualObject.largeImage
        APIRequestManager.manager.getData(endPoint: largeImageURL) { (data: Data?) in
            if  let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    self.largeImageView.image = validImage
                }
            }
        }
        
        var text = ""
        
        if individualObject.artist != "" {
            text += "Artist: \(individualObject.artist)\n"
        }
        if individualObject.object != "" {
            text += "Object: \(individualObject.object)\n"
        }
        if individualObject.place != "" {
            text += "Place: \(individualObject.place)\n"
        }
        if individualObject.location != "" {
            text += "Location: \(individualObject.location)\n"
        }
        if individualObject.title != "" {
            text += "Title: \(individualObject.title)\n"
        }
        if individualObject.dateText != "" {
            text += "Date: \(individualObject.dateText)\n"
        }
        if individualObject.slug != "" {
            text += "Slug: \(individualObject.slug)\n"
        }
        if individualObject.collectionCode != "" {
            text += "Collection Code: \(individualObject.collectionCode)\n"
        }
        if individualObject.largeImage != "" {
            text += "Image: \(individualObject.largeImage)"
        }
        
        imageDetailsTextView.text = text
        
    }
}
