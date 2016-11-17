//
//  ViewController.swift
//  VictoriaAlbert
//
//  Created by Kadell on 11/10/16.
//  Copyright © 2016 Kadell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var museum: MuseumObj?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loadImage() {
         let correctId = museum!.imageID
        var arr = [Character]()
        var new = ""
        for x in correctId.characters {
            arr.append(x)
        }
        arr.popLast()
        arr.popLast()
        arr.popLast()
        arr.popLast()
        
        for x in arr {
            new += String(x)
        }
            
        let end = "http://media.vam.ac.uk/media/thira/collection_images/\(new)/\(correctId)_jpg_o.jpg"
        
        APIRequestManager.manager.getData(endPoint: end ) { (data: Data?) in
            if let d = data {
                self.imageView.image = UIImage(data: d)
            }
            DispatchQueue.main.async {
                self.imageView.reloadInputViews()
            }
        }
   
    }
 

    
}

