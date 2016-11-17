//
//  VicAlbMuseumTableViewController.swift
//  VictoriaAlbert
//
//  Created by Kadell on 11/10/16.
//  Copyright © 2016 Kadell. All rights reserved.
//

import UIKit


class VicAlbMuseumTableViewController: UITableViewController {


    
    var museumObjects: [MuseumObj] = []
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMuseumObj()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadMuseumObj() {
        APIRequestManager.manager.getData(endPoint:"http://www.vam.ac.uk/api/json/museumobject/") { (data: Data?) in
            if data != nil {
                if let objects = MuseumObj.getMuseumObj(from: data!) {
                    self.museumObjects = objects
                    print("Objects are here ")
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuseumCell", for: indexPath)
        
        let path = museumObjects[indexPath.row]
        cell.textLabel?.text = path.object + ", " + path.date + ", " + path.place
        cell.detailTextLabel?.text = path.title
        
        let correctId = museumObjects[indexPath.row].imageID
        let endOfDomain = correctId.index(correctId.endIndex, offsetBy: -4)
        let rangeOfDomain = correctId.startIndex ..< endOfDomain
        let otherId = correctId[rangeOfDomain]
        
        
        
        APIRequestManager.manager.getData(endPoint: "http://media.vam.ac.uk/media/thira/collection_images/\(otherId)/\(correctId)_jpg_o.jpg" ) { (data: Data?) in
            if let validPic = data {
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: validPic)
                    cell.setNeedsLayout()
                }
            }
        }
        
        return cell
    }
    
    
    
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedObject = self.museumObjects[indexPath.row]
        performSegue(withIdentifier: "MuseumPhotoSegue", sender: selectedObject)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MuseumPhotoSegue" {
            let detailController = segue.destination as! ViewController
            let selectedObject = sender as? MuseumObj
            detailController.museum = selectedObject
            
        }
        
    }
    
    

}
