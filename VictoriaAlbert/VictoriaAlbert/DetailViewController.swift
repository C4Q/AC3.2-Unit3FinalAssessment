//
//  DetailViewController.swift
//  VictoriaAlbert
//
//  Created by Erica Y Stevens on 11/10/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var fullSizeMuseumObjectImageView: UIImageView!
    @IBOutlet weak var museumObjectArtistLabel: UILabel!
    
    @IBOutlet weak var museumObjectLocationLabel: UILabel!
    
    // MARK: Properties
    var imageURL = ""
    var locationString = ""

    var artistNameString = ""
    
    //MARK: Built-In Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: imageURL) {
            fullSizeMuseumObjectImageView.loadImageUsing(url: url)
        }
       
        museumObjectLocationLabel.text = locationString
        museumObjectArtistLabel.text = artistNameString
    }
    
}
