//
//  MuseumInfoTableViewController.swift
//  Unit3FinalAssessment
//
//  Created by C4Q on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MuseumInfoTableViewController: UITableViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var searchField: UITextField!
    
    var endPoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=ring"
    
    let liamsDadsVAPieceEndPoint = "http://www.vam.ac.uk/api/json/museumobject/search?namesearch=michael+kane"

    var objects = [MuseumObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateObjects()
        
        self.navigationItem.title = "Ring"
     
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuseumCell", for: indexPath)
        let currentObject = objects[indexPath.row]
        
        cell.textLabel?.text = currentObject.title
        cell.detailTextLabel?.text = currentObject.subtitle
        
        cell.imageView?.image = #imageLiteral(resourceName: "default-placeholder")
        
        APIManager.manager.getData(endPoint: currentObject.thumbImage) {(data: Data?) in
            if let d = data {
                cell.imageView?.image = UIImage(data: d)
            }
            DispatchQueue.main.async {
                cell.setNeedsLayout()
            }
        }

        return cell
    }
 

    // MARK: - TextField
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let term = searchField.text {
            self.upDateEndPoint(term: term)
            self.updateObjects()
            self.navigationItem.title = term
            
        }
        return true
    }// called when 'return' key pressed. return NO to ignore.
    
    // MARK: - Methods
    
    func upDateEndPoint (term: String) {
        
       let correctedTerm = term.replacingOccurrences(of: " ", with: "+")
        
        self.endPoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=\(correctedTerm)"
    }
    
    func updateObjects () {
        APIManager.manager.getData(endPoint: self.endPoint) { (data: Data?) in
            if let d = data {
                self.objects = MuseumObject.parseData(data: d)!
            } else {
                APIManager.manager.getData(endPoint: self.liamsDadsVAPieceEndPoint, callback: { (data: Data?) in
                    self.objects = MuseumObject.parseData(data: data!)!
                })
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            let dvc = segue.destination as! DetailViewController
            let cellIndex = self.tableView.indexPath(for: sender as! UITableViewCell)!
            
            dvc.object = objects[cellIndex.row]
        }
        
    }
    

}
