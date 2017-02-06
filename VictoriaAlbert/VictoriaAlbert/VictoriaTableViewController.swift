//
//  VictoriaTableViewController.swift
//  VictoriaAlbert
//
//  Created by Margaret Ikeda on 11/10/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import UIKit

class VictoriaTableViewController: UITableViewController {

    var victoriaObjects = [VictoriaObject]()
    let reuseIdentifier = "VictoriaCell"
    let victoriaObjectEndpoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=ring"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVictoriaObjects()
    }
    
        func loadVictoriaObjects() {
            ApiManager.manager.getVictoriaObjectData(endpoint: victoriaObjectEndpoint) { (data: Data?) in
            
                    if let victoriaObjects = VictoriaObject.victoriaObjects(from: data!) {
                        print("Got Victoria Objects \(victoriaObjects)")
                        
                        self.victoriaObjects = victoriaObjects
                        
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
        return victoriaObjects.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let museumObject = victoriaObjects[indexPath.row]
        cell.textLabel?.text = ("\(museumObject.name), \(museumObject.dateText), \(museumObject.place)")
        cell.detailTextLabel?.text = museumObject.title
        return cell
    }

        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
