//
//  DetailObjectViewController.swift
//  VictoriaAlbert
//
//  Created by Ana Ma on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class DetailObjectViewController: UIViewController {
    
    @IBOutlet weak var objectImageView: UIImageView!
    @IBOutlet weak var objectDateTextLabel: UILabel!
    @IBOutlet weak var objectPlaceLabel: UILabel!
    @IBOutlet weak var objectArtistLabel: UILabel!
    @IBOutlet weak var objectlocationLabel: UILabel!
    
    var selectedObject: Object!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = selectedObject.object
        loadInfo()
    }

    func loadInfo () {
        self.objectDateTextLabel.text = "Date: " + selectedObject.date_text
        self.objectPlaceLabel.text = "Place: " + selectedObject.place
        self.objectArtistLabel.text = "Artist: " + selectedObject.artist
        self.objectlocationLabel.text = "Location: " + selectedObject.location
        
        guard let validImageURLString = selectedObject.imageLargeURLString else {return}
        
        APIRequestManager.manager.getData(endpoint: validImageURLString) { (data) in
            guard let validData = data else {return}
            
            DispatchQueue.main.async {
                self.objectImageView.image = UIImage(data: validData)
            }
        }
    }
}
