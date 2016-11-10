//
//  ObjectDetailViewController.swift
//  VictoriaAlbert
//
//  Created by Cris on 11/10/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import UIKit

class ObjectDetailViewController: UIViewController {
    
    @IBOutlet weak var objectLocationLabel: UILabel!
    @IBOutlet weak var largeImageView: UIImageView!
    var objectDetail: Records!

    override func viewDidLoad() {
        super.viewDidLoad()
        largeImageView.downloadImage(urlString: objectDetail.largeImageURL)
        objectLocationLabel.text = objectDetail.location
        self.title = objectDetail.object
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
