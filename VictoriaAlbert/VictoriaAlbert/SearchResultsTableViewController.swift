//
//  SearchResultsTableViewController.swift
//  VictoriaAlbert
//
//  Created by Jermaine Kelly on 11/10/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    var results: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeSearchBar()
        getResults()
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell", for: indexPath) as! ResultTableViewCell
        
        let record = results[indexPath.row]
        cell.nameLabel.text = "\(record.name), \(record.date), \(record.place)"
        cell.titleLabel.text = record.title
        
        var imageIdForUrl = ""
        
        for (index,character) in record.imageID.characters.enumerated(){
            if index == 6 {
                break
            }
            imageIdForUrl += String(character)
        }
        
        let imageUrl = "http://media.vam.ac.uk/media/thira/collection_images/\(imageIdForUrl)/\(record.imageID)_jpg_o.jpg"
        print(imageUrl)
        
        
        
        APIRequestManager.manager.getData(from: imageUrl) { (data) in
            if let validData = data{
                DispatchQueue.main.async {
                    cell.resultImageView.image = UIImage(data: validData)
                  //  cell.setNeedsDisplay()
                    
                }
                
            }
        }
        
//        DispatchQueue.main.async {
//            cell.resultImageView.image = self.getImage(for: record.imageID)
//            cell.setNeedsDisplay()
//            
//        }
//        
        
        
        
        
        return cell
    }
    
    //MARK: Search bar delgate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getResults(for: searchBar.text!)
    }
    
    
    //MARK:- Utilities
    
    func getResults(for searchterm:String = "ring"){
        let endpoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=\(searchterm)"
        APIRequestManager.manager.getData(from: endpoint) { (data) in
            if let validData = data{
                print("Data recieved")
                self.results = Record.makeObjects(from: validData)!
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    //adds search bar to navigation bar
    func makeSearchBar(){
        let searchbar = UISearchBar()
        searchbar.showsCancelButton = false
        //  self.tableView.sectionHeaderHeight = 30
        // self.tableView.tableHeaderView = searchbar
        searchbar.delegate = self
        self.navigationItem.titleView = searchbar
        searchbar.placeholder = "search here...."
    }
    
    
    func getImage(for imageId:String)-> UIImage?{
        
        var recordImage: UIImage? = UIImage()
        var imageIdForUrl = ""
        for (index,character) in imageId.characters.enumerated(){
            if index == 6 {
                break
            }
            imageIdForUrl += String(character)
        }
        let imageUrl = "http://media.vam.ac.uk/media/thira/collection_images/\(imageIdForUrl)/\(imageId)_jpg_o.jpg"
        print(imageUrl)
        
        
        APIRequestManager.manager.getData(from: imageUrl) { (data) in
            if let validData = data{
                recordImage = UIImage(data: validData)
                print("image set")
                
            }
        }
        return recordImage
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recordVC = segue.destination as? RecordDetailViewController{
            if segue.identifier == "showRecordDetail"{
                if let index = tableView.indexPathForSelectedRow{
                    recordVC.record = self.results[index.row]
                    
                }
            }
            
        }
    }
    
    
}
