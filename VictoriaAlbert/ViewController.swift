//
//  ViewController.swift
//  VictoriaAlbert
//
//  Created by Marty Avedon on 11/10/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bigPic: UIImageView!
    let endpoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=skull"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        APIHelper.manager.getData(endPoint: endpoint) { (returnedData: Data?) in
            guard let validData = returnedData else { return }
            DispatchQueue.main.async {
                self.bigPic.image = UIImage(data: validData) // this doesn't look quite right; can't we pull this from the object we created on the previous page? if we cache it i guess
                self.view.reloadInputViews()
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
