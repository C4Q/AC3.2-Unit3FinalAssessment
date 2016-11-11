//
//  RecordDetailViewController.swift
//  VictoriaAlbert
//
//  Created by Jermaine Kelly on 11/10/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class RecordDetailViewController: UIViewController {
    
    var record: Record!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var recordImageView: UIImageView!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        self.title = record.name
        infoLabel.text = "This item is found in \(record.place) at the \(record.location).\nThe artist is \(record.artist)"
        getImage()
        
    }
      
    func getImage(){
        
        var imageIdForUrl = ""
        for (index,character) in record.imageID.characters.enumerated(){
            if index == 6 {
                break
            }
            imageIdForUrl += String(character)
        }
        let imageUrl = "http://media.vam.ac.uk/media/thira/collection_images/\(imageIdForUrl)/\(record.imageID).jpg"
        print(imageUrl)
        
        APIRequestManager.manager.getData(from: imageUrl) { (data) in
            if let validData = data{
                DispatchQueue.main.async {
                    self.recordImageView.image = UIImage(data: validData)

                }
                
            }
        }
        
    }
    
    
}
