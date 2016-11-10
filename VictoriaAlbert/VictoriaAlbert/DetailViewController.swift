//
//  DetailViewController.swift
//  VictoriaAlbert
//
//  Created by Tong Lin on 11/10/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import UIKit
/*let imageID: String
 let artist: String
 let object: String
 let place: String
 let location: String
 let sys_updated: String
 let year_start: Int
 let object_number: String*/
class DetailViewController: UIViewController {

    var object: Object!

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var largeImage: UIImageView!
    @IBOutlet weak var objectNumLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    func loadData(){
        navigationItem.title = object.object
        self.artistLabel.text = object.artist
        self.placeLabel.text = object.place
        self.lastUpdatedLabel.text = object.sys_updated
        self.locationLabel.text = object.location
        self.yearLabel.text = String(object.year_start)
        self.objectNumLabel.text = object.object_number
        APIRequestManager.manager.downloadImage(imageID: object.imageID, switchPic: 1){ (imageData: Data?) in
            if imageData != nil{
                DispatchQueue.main.async {
                    self.largeImage.image = UIImage(data: imageData!)
                }
            }
        }
    }


}
