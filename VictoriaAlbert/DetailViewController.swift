//
//  DetailViewController.swift
//  VictoriaAlbert
//
//  Created by Eashir Arafat on 11/14/16.
//  Copyright © 2016 Evan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var ring: Ring?
    @IBOutlet weak var ringImageView: UIImageView!
    @IBOutlet weak var museumNumberLabel: UILabel!
    
    @IBOutlet weak var locationTextView: UITextView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        var firstSixLetters = [Character]()
        var emptyString = ""
        for eachCharacter in ((ring?.imageID)?.characters)! {
            
            if firstSixLetters.count != 6 {
                firstSixLetters.append(eachCharacter)
            }
            
        }
        for eachElement in firstSixLetters {
            emptyString += (String(eachElement))
            
        }
        let url = "http://media.vam.ac.uk/media/thira/collection_images/\(emptyString)/\((ring?.imageID)!).jpg"
        
        APIRequestManager.manager.downloadImage(urlString: url ) { (data: Data?) in
            if  let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    self.ringImageView?.image = validImage
                    self.title = (self.ring?.object)!
                    self.museumNumberLabel.text = String((self.ring?.museumNumber)!)
                    self.locationTextView.text = (self.ring?.location)
                }
            }
        }
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
