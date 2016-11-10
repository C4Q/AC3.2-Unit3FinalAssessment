//
//  MuseumObjectsTableViewController.swift
//  VictoriaAlbert
//
//  Created by Erica Y Stevens on 11/10/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import UIKit

internal let query = "vase"

class MuseumObjectsTableViewController: UITableViewController {
    
    // MARK: Properties
    internal let apiEndpoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=\(query)"
    internal var museumObjects = [MuseumObject]()
    
    // MARK: Built-In Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = query.uppercased()
        
        APIRequestManager.manager.getDataFrom(apiEndpoint: apiEndpoint) { (museumObjects: [MuseumObject]?) in
            if museumObjects != nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.museumObjects = museumObjects!
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuseumObjectCell", for: indexPath) as! MuseumObjectTableViewCell
        
        let item = museumObjects[indexPath.row]
        
        cell.museumObjectTitleLabel.text = "\(item.objectName), \(item.dateText), \(item.place)"
        cell.museumObjectSubtitleLabel.text = "\(item.title)"
        if let url = APIRequestManager.manager.getThumbnailImageURLfrom(imageID: item.imageID) {
            cell.museumObjectImageView.image = nil
            cell.museumObjectImageView.loadImageUsing(url: url)
        }
        
        return cell
    }
    
     //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? DetailViewController, let cell = sender as? MuseumObjectTableViewCell, let indexPath = self.tableView.indexPath(for: cell) {
            let item = museumObjects[indexPath.row]

            vc.imageURL = APIRequestManager.manager.getFullSizedImageURLFrom(imageID: item.imageID)
            vc.locationString = item.location
            vc.artistNameString = item.artist
            
            vc.title = "\(item.objectName), \(item.dateText)"
            
        }
    }
}
