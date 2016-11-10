//
//  mainTableViewController.swift
//  VictoriaAlbert
//
//  Created by Thinley Dorjee on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class mainTableViewController: UITableViewController {

    var tableViewCellIdentifier = "tableViewCellIdentifier"
    var endPoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=ring"
    
    var imageEndPoint = "http://media.vam.ac.uk/media/thira/collection_images/2006AM/2006AM6763.jpg"
    
    
    var rings = [Ring]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "The Ring World"
        loadData()
    }
    
    func loadData(){
        APIRequestManager.manager.getData(endPoint: endPoint) { (data: Data?) in
            if data != nil{
                
                guard let validData = data else {return}
                self.rings = Ring.getJsonData(from: validData)!
                
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
        return rings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
//Seal ring, ca. 1545 (made), London
        var thisCell = rings[indexPath.row]
        
        var name = thisCell.object
        var date = thisCell.date
        var place = thisCell.place
        
        cell.textLabel?.text = "\(name), \(date), \(place)"
        APIRequestManager.manager.downloadImage(urlString: imageEndPoint) { (data) in
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: data)
                cell.setNeedsLayout()
            }
        }
   

        return cell
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showView"{
            if let destination = segue.destination as? ViewController,
                let cell  = sender as? UITableViewCell,
                let ip = tableView.indexPath(for: cell) {
                
                destination.detailRing = rings[ip.row]
                
            }
        }
    }
    

}
