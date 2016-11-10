//
//  VAMDetailViewController.swift
//  VictoriaAlbert
//
//  Created by Karen Fuentes on 11/10/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import UIKit

class VAMDetailViewController: UIViewController {
    var recordThatWasSelected: Record?
    @IBOutlet weak var fullImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

 
    func loadData() {
        let fullImage = recordThatWasSelected!.imageID
        let firstSixINeed = fullImage.startIndex..<fullImage.index(fullImage.startIndex, offsetBy: 6)
        let imageSubscript = fullImage[firstSixINeed]
        let imageURL = "http://media.vam.ac.uk/media/thira/collection_images/\(imageSubscript)/\(fullImage).jpg"
        
        APIRequestManager.manager.getImage(urlString: imageURL) { (validData : Data) in
            DispatchQueue.main.async {
                self.fullImage.image = UIImage(data: validData)
            }
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
