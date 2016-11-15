//
//  RingTableViewController.swift
//  VictoriaAlbert
//
//  Created by Eashir Arafat on 11/14/16.
//  Copyright © 2016 Evan. All rights reserved.
//

import UIKit

class RingTableViewController: UITableViewController {
        
        var rings: [Ring] = []
        var detailString = ""
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Victoria Albert"
            APIRequestManager.manager.getData(endPoint: "http://www.vam.ac.uk/api/json/museumobject/search?q=ring") { (data: Data?) in
                if  let validData = data,
                    let validObjects = Ring.getRings(from: validData) {
                    self.rings = validObjects
                    DispatchQueue.main.async {
                        self.tableView?.reloadData()
                    }
                }
            }
        }
        
        /*
         
         {
         records: [
         {
         pk: 8757,
         model: "collection.Ring",
         fields: {
         primary_image_id: "2006AM3589",
         object: "Gimmel ring",
         place: "Germany",
         date_text: "ca.1600 (made)"
         
         
         }
         }
         
         
         */
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return self.rings.count
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ringCell", for: indexPath)
            
            let ring = rings[indexPath.row]
            var firstSixLetters = [Character]()
            var emptyString = ""
            for eachCharacter in (ring.imageID).characters {
                
                if firstSixLetters.count != 6 {
                    firstSixLetters.append(eachCharacter)
                }
                
            }
            for eachElement in firstSixLetters {
                emptyString += (String(eachElement))
                detailString = emptyString
            }
            // Seal ring, ca. 1545 (made), London
            cell.textLabel?.adjustsFontSizeToFitWidth = true 
            cell.textLabel?.text = ring.object + ", " + ring.dateText + ", " + ring.place
            cell.detailTextLabel?.text = String(ring.yearStart)
            cell.imageView?.image = nil
            //http://media.vam.ac.uk/media/thira/collection_images/2007BL/2007BL8769_jpg_o.jpg
            APIRequestManager.manager.downloadImage(urlString: "http://media.vam.ac.uk/media/thira/collection_images/\(emptyString)/\(ring.imageID)_jpg_o.jpg") { (data: Data?) in
                if  let validData = data,
                    let validImage = UIImage(data: validData) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = validImage
                        cell.setNeedsLayout()
                    }
                }
            }
            
            
            return cell
        }
        
        
        
        
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let dvc = segue.destination as? DetailViewController,
                let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) {
                dvc.ring = rings[indexPath.row]
                
                
            }
        }
        

}
