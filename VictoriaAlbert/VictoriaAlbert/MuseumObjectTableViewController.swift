//
//  MuseumObjectTableViewController.swift
//  VictoriaAlbert
//
//  Created by Sabrina Ip on 11/10/16.
//  Copyright © 2016 Sabrina. All rights reserved.
//

import UIKit

class MuseumObjectTableViewController: UITableViewController, UITextFieldDelegate {
    
    var museumObjects = [MuseumObject]()
    var searchText: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchInput = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        APIRequestManager.manager.getData(endPoint: "http://www.vam.ac.uk/api/json/museumobject/search?q=\(searchInput)") { (data) in
            if let unwrappedData = MuseumObject.getDataFromJson(data: data!) {
                self.museumObjects = unwrappedData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        self.title = "Victoria and Albert Museum: \(searchText.capitalized)"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return museumObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuseumObjectCell", for: indexPath) as! MuseumObjectTableViewCell
        
        let museumObject = museumObjects[indexPath.row]
        cell.titleLabel.text = "\(museumObject.object), \(museumObject.dateText), \(museumObject.place)"
        cell.subtitleLabel.text = museumObject.title
        
        let smallImageURL = museumObject.smallImage
        
        APIRequestManager.manager.getData(endPoint: smallImageURL) { (data: Data?) in
            if  let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    cell.smallImageView.image = validImage
                    //cell.setNeedsLayout()
                }
            }
        }
        
        return cell
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let modvc = segue.destination as? MuseumObjectDetailViewController,
            let cell = sender as? MuseumObjectTableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            modvc.individualObject = museumObjects[indexPath.row]
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
