//
//  ObjectTableViewController.swift
//  VictoriaAlbert
//
//  Created by Cris on 11/10/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import UIKit

class ObjectTableViewController: UITableViewController {

    var objects = [Records]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getObjectInfo(url: "http://www.vam.ac.uk/api/json/museumobject/search?q=ring")
    }

    func getObjectInfo(url: String) {
        APIRequestManager.manager.getData(endPoint: url) { (data: Data?) in
            if let validData = data,
                let validObjects = Records.object(from: validData) {
                self.objects = validObjects
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectCellID", for: indexPath)
        
        if let cells: ObjectTableViewCell = cell as? ObjectTableViewCell {
            let object = objects[indexPath.row]
            cells.objectNameLabel.text = object.object
            cells.objectInfoLabel.text = "\(object.date_text), \(object.place)"
            cells.objectImageView.downloadImage(urlString: object.smallImageURL)
        }
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToDetials" {
            if let dest = segue.destination as? ObjectDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                dest.objectDetail = objects[indexPath.row]
            }
        }
    }
    

}
