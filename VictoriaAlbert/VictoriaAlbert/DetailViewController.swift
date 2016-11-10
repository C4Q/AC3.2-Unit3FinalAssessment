//
//  DetailViewController.swift
//  VictoriaAlbert
//
//  Created by Marcel Chaucer on 11/10/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
     var  detailObject: MuseumObject?

    @IBOutlet weak var pictureOfObject: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let detail = detailObject {
            self.title = detail.object
            
            var firstSix = detail.imageID
            let range = firstSix.index(firstSix.endIndex, offsetBy: -4)..<firstSix.endIndex
            let smallPic = firstSix.removeSubrange(range)
            
            

            
            
    let fullImage = "http://media.vam.ac.uk/media/thira/collection_images/\(firstSix)/\(detail.imageID).jpg"
            
            let url = URL(string: fullImage)
            let data = try? Data(contentsOf: url!)
            self.pictureOfObject.image = UIImage(data: data!)
        }

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
