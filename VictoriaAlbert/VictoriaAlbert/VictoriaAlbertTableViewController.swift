//
//  VictoriaAlbertTableViewController.swift
//  VictoriaAlbert
//
//  Created by Ana Ma on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class VictoriaAlbertTableViewController: UITableViewController, UISearchBarDelegate {
    //API: http://www.vam.ac.uk/api
    let urlString = "http://www.vam.ac.uk/api/json/museumobject/"
    
    var objectsArray = [Object]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeSearchBar()
        APIRequestManager.manager.getData(endpoint: urlString) { (data: Data?) in
            guard let validData = data else {return}
            guard let validObjects = Object.getCollectionObject(from: validData) else {return}
            self.objectsArray = validObjects
            
            dump(validData)
            dump(self.objectsArray)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(objectsArray.count)
        return objectsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "objectCellIdentifier", for: indexPath)
        
        let object = objectsArray[indexPath.row]
        let titleText = "\(object.object), \(object.date_text) - \(object.place)"
        let detailText = "\(object.title)"
        
        cell.textLabel?.text = titleText
        cell.detailTextLabel?.text = detailText
        
        if let validImageURLString = object.imageURLString {
            APIRequestManager.manager.getData(endpoint: validImageURLString) { (data) in
                guard let validData = data else {return}
                
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: validData)
                }
            }
        } else {
            cell.imageView?.image = UIImage(named: "default-placeholder")
        }
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedObject = objectsArray[indexPath.row]
//        performSegue(withIdentifier: "detailObjectViewControllerSegue", sender: selectedObject)
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailObjectViewControllerSegue" {
            let detailObjectViewController = segue.destination as! DetailObjectViewController
//            let selectedObject = sender as? Object
//            detailObjectViewController.selectedObject = selectedObject
            if let cell = sender as? UITableViewCell {
                if let indexPath = tableView.indexPath(for: cell) {
                    let selectedObject = objectsArray[indexPath.row]
                    detailObjectViewController.selectedObject = selectedObject
                }
            }
//            let indexPath = tableView.indexPathForSelectedRow {
//                let selectedObject = objectsArray[indexPath.row]
//                detailObjectViewController.selectedObject = selectedObject
//            }
            
        }
    }
    
    func makeSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Enter search here"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        let searchTextWithPlus = searchText.replacingOccurrences(of: " ", with: "+")
        
        //http://www.vam.ac.uk/api/json/museumobject/search?objectnamesearch=necklace
        let searchTextURLString = "http://www.vam.ac.uk/api/json/museumobject/search?objectnamesearch=\(searchTextWithPlus)"
        
        APIRequestManager.manager.getData(endpoint: searchTextURLString) { (data) in
            guard let validData = data else {return}
            
            guard let validObjects = Object.getCollectionObject(from: validData) else {return}
            self.objectsArray = validObjects
            
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
}
