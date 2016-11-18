//
//  MuseumTableViewController.swift
//  VictoriaAlbert
//
//  Created by Harichandan Singh on 11/10/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import UIKit

class MuseumTableViewController: UITableViewController, UISearchBarDelegate {
    //MARK: Properties
    var searchValue: String = "ring"
    var apiEndpoint: String {
        return "http://www.vam.ac.uk/api/json/museumobject/search?q=\(searchValue)"
    }
    internal var museums: [Museum] = []
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMuseum()
        createSearchBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadMuseum() {
        APIRequestManager.manager.getData(apiEndpoint: apiEndpoint) { (data: Data) in
            if let museums = Museum.turnDataIntoMuseumArray(data: data) {
                self.museums = museums
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for an object in the Victoria and Albert museum."
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchValue = text
        APIRequestManager.manager.getData(apiEndpoint: apiEndpoint) { (data: Data) in
            if let museums = Museum.turnDataIntoMuseumArray(data: data) {
                self.museums = museums
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
        return self.museums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "museumCell", for: indexPath)
        let museumItem = museums[indexPath.row]
        
        //image URL string construction
        let imageID = museumItem.primaryImageID
        let firstSixOfImageID = imageID[imageID.startIndex..<imageID.index(imageID.startIndex, offsetBy: 6)]
        var imageEndpoint: String {
            return "http://media.vam.ac.uk/media/thira/collection_images/\(firstSixOfImageID)/\(imageID)_jpg_o.jpg"
        }
        
        APIRequestManager.manager.getData(apiEndpoint: imageEndpoint) { (data: Data) in
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: data)
                cell.textLabel?.text = "\(museumItem.object), \(museumItem.dateText) - \(museumItem.place)"
                cell.detailTextLabel?.text = museumItem.title
            }
        }
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "museumSegue" {
            if let cell = sender as? UITableViewCell {
                let cellIndexPath = self.tableView.indexPath(for: cell)
                if let dvc = segue.destination as? DetailViewController {
                    let museumItem = museums[cellIndexPath!.row]
                    let imageID = museumItem.primaryImageID
                    let firstSixOfImageID = imageID[imageID.startIndex..<imageID.index(imageID.startIndex, offsetBy: 6)]
                    var imageEndpoint: String {
                        return "http://media.vam.ac.uk/media/thira/collection_images/\(firstSixOfImageID)/\(imageID).jpg"
                    }
                    
                    dvc.fullSizeImageString = imageEndpoint
                    dvc.artist = museumItem.artist
                    dvc.location = museumItem.location
                    dvc.museumNumber = museumItem.museumNumber
                    dvc.year = String(museumItem.year)
                    
                }
            }
        }
        
    }
}
