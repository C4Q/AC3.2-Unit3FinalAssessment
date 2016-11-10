//
//  DetailViewController.swift
//  VictoriaAlbert
//
//  Created by Amber Spadafora on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var photo: Photo?
    
    @IBOutlet weak var largePhoto: UIImageView!
    
//    func setData(photos: Photo){
//        
//        let imageUrl = photos.createSmallImageUrl(photoID: photos.photoID)
//        ApiManager.manager.getData(endPointUrl: URL(string: imageUrl)!, callback: { (data) in
//            guard let validData = data else {
//                print("Api Request for data was unsuccessful")
//                return
//            }
//            DispatchQueue.main.async {
//                self.imageIcon.image = UIImage(data: validData)
//                self.titleLabel.text = photos.object + " " + photos.date + " " + photos.place
//            }
//            
//        })
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let pic = photo {
            let imageUrl = pic.createLargemageUrl(photoID: pic.photoID)
            
            ApiManager.manager.getData(endPointUrl: URL(string: imageUrl)!, callback: { (data) in
                guard let validData = data else {
                    return
                }
                DispatchQueue.main.async {
                    self.largePhoto.image = UIImage(data: validData)
                }
            })
        }
        
    }

    
}
