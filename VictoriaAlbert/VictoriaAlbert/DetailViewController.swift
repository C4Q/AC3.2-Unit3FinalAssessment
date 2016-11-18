//
//  DetailViewController.swift
//  VictoriaAlbert
//
//  Created by Harichandan Singh on 11/10/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: - Properties
    var fullSizeImageString: String = ""
    var artist: String = ""
    var location: String = ""
    var museumNumber: String = ""
    var year: String = ""
    
    
    //MARK: - Outlets
    @IBOutlet weak var fullSizeImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var museumNumberLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        configureLabels()
        self.navigationItem.title = "Victoria and Albert Museum"
    }
    
    func loadImage() {
        APIRequestManager.manager.getData(apiEndpoint: fullSizeImageString) { (data: Data) in
            DispatchQueue.main.async {
                self.fullSizeImageView.image = UIImage(data: data)
            }
        }
    }
    
    func configureLabels() {
        artistLabel.text = "Artist: \(self.artist)"
        locationLabel.text = "Location: \(self.location)"
        museumNumberLabel.text = "Museum Number: \(self.museumNumber)"
        yearLabel.text = "Year: \(self.year)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
