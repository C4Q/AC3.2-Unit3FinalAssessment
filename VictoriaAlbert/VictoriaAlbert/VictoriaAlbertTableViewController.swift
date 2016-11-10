//
//  VictoriaAlbertTableViewController.swift
//  VictoriaAlbert
//
//  Created by Marcel Chaucer on 11/10/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import UIKit

class VictoriaAlbertTableViewController: UITableViewController, UISearchBarDelegate {
    var objects: [MuseumObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        APIRequestManager.manager.getData(endPoint: "http://www.vam.ac.uk/api/json/museumobject/search?q=swords") { (data: Data?) in
            if  let validData = data,
                let validInfo = MuseumObject.objects(from: validData)
                 {
                self.objects = validInfo
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func createSearchBar() {
        let searchbar = UISearchBar()
        searchbar.showsCancelButton = false
        searchbar.placeholder = "Enter object to search"
        searchbar.delegate = self
        self.navigationItem.titleView = searchbar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        APIRequestManager.manager.getData(endPoint: "http://www.vam.ac.uk/api/json/museumobject/search?q=\(searchTerm)") { (data: Data?) in
            if  let validData = data,
                let validInfo = MuseumObject.objects(from: validData)
            {
                self.objects = validInfo
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
        return objects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "victoriaCell", for: indexPath)
        let museumObject = objects[indexPath.row]
        var thumbNailPic = museumObject.imageID
        let range = thumbNailPic.index(thumbNailPic.endIndex, offsetBy: -4)..<thumbNailPic.endIndex
        let smallPic = thumbNailPic.removeSubrange(range)

        
        let url = URL(string: "http://media.vam.ac.uk/media/thira/collection_images/\(thumbNailPic)/\(museumObject.imageID)_jpg_o.jpg")
        let data = try? Data(contentsOf: url!)

        
        
        

        
        cell.textLabel?.text = "\(museumObject.object), \(museumObject.date), \(museumObject.place)"
        cell.detailTextLabel?.text = museumObject.title
        if data != nil {
        cell.imageView?.image = UIImage(data: data!)
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "placeholder")
        }
        return cell
    }
 

  

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let destination = segue.destination as? DetailViewController {
                destination.detailObject =  sender as? MuseumObject
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedObject = self.objects[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: selectedObject)
    }

    

}
