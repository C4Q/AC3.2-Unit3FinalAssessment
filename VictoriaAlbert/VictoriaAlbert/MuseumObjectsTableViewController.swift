//
//  MuseumObjectsTableViewController.swift
//  VictoriaAlbert
//
//  Created by Madushani Lekam Wasam Liyanage on 11/10/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class MuseumObjectsTableViewController: UITableViewController {
    
    let museumAPI = "http://www.vam.ac.uk/api/json/museumobject/search?q="
    var museumAPIEndPoint = ""
    var museumObjects: [MuseumObject] = []
    var selectedObject: MuseumObject?
    var searchKeyword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(searchKey)
        if let searchKey = searchKeyword {
            museumAPIEndPoint = museumAPI + searchKey
        }
        
        
        APIRequestManager.manager.getData(endPoint: museumAPIEndPoint) { (data: Data?) in
            if  let validData = data,
                let validObjects = MuseumObject.getMuseumObjects(from: validData) {
                self.museumObjects = validObjects
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return museumObjects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuseumObjectCellIdentifier", for: indexPath)
        
        let museumObjectAtIndex = museumObjects[indexPath.row]
        let ObjectDetailString = museumObjectAtIndex.objectName + ", " + museumObjectAtIndex.dateText+", " + museumObjectAtIndex.placeName
        
        cell.textLabel?.text = ObjectDetailString
        cell.detailTextLabel?.text = museumObjectAtIndex.titleField
        cell.imageView?.image = nil
        
        
        
        let imageId = museumObjectAtIndex.imageString
        
        if imageId != "" {
            let imageIdArray = Array(imageId.characters)
            var yearID = ""
            
            for i in 0...5 {
                yearID += String(describing: imageIdArray[i])
            }
            
            let imageEndURL = "http://media.vam.ac.uk/media/thira/collection_images/"
            let slash = "/"
            let sizeString = "_jpg_o"
            let imageTypeString = ".jpg"
            
            
            let imageEndPoint = imageEndURL + yearID + slash + imageId + sizeString + imageTypeString
            
            APIRequestManager.manager.getData(endPoint: imageEndPoint ) { (data: Data?) in
                if  let validData = data,
                    let validImage = UIImage(data: validData) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = validImage
                        cell.setNeedsLayout()
                        
                    }
                }
            }
        }
        else {
            cell.imageView?.image = UIImage(named: "noPreview")
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedObject = museumObjects[indexPath.row]
        performSegue(withIdentifier: "DetailViewSegue", sender: selectedObject)
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailViewSegue" {
            
            if let dvc = segue.destination as? DetailViewController {
                dvc.object = selectedObject
            }
            
        }
        
        
    }
    
    
}
