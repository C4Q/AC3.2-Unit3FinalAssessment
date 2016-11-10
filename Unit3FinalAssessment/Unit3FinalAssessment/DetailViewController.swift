//
//  DetailViewController.swift
//  Unit3FinalAssessment
//
//  Created by Eric Chang on 11/10/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var objectImageView: UIImageView!
    var thisObject: MuseumObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData() {
        let image = thisObject!.imageID
        let firstSixIndex = image.startIndex..<image.index(image.startIndex, offsetBy: 6)
        let firstSix = image[firstSixIndex]
        let imageURL = "http://media.vam.ac.uk/media/thira/collection_images/\(firstSix)/\(image).jpg"
        
        APIRequestManager.manager.downloadImage(urlString: imageURL) { (returnedData: Data) in
            DispatchQueue.main.async {
                self.objectImageView.image = UIImage(data: returnedData)
            }
        }
    }

}
