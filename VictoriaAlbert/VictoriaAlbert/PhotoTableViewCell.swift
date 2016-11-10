//
//  PhotoTableViewCell.swift
//  VictoriaAlbert
//
//  Created by Amber Spadafora on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(photos: Photo){
        
        let imageUrl = photos.createSmallImageUrl(photoID: photos.photoID)
        ApiManager.manager.getData(endPointUrl: URL(string: imageUrl)!, callback: { (data) in
            guard let validData = data else {
                print("Api Request for data was unsuccessful")
                return
            }
            DispatchQueue.main.async {
                self.imageIcon.image = UIImage(data: validData)
                self.titleLabel.text = photos.object + " " + photos.date + " " + photos.place
            }

        })
    }

}
