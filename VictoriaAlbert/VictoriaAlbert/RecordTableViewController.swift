//
//  RecordTableViewController.swift
//  VictoriaAlbert
//
//  Created by Victor Zhong on 11/10/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import UIKit

class RecordTableViewController: UITableViewController, UITextFieldDelegate {
    var records = [Record]()
    var searchTerm = "ring"
    var locationDict = [String : Int]()
    var locationArray = [String]()
    var sorted = false
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    @IBAction func sortButtonTapped(_ sender: UIBarButtonItem) {
        sorted = !sorted
        self.tableView.reloadData()
        if sorted {
            sortButton.image = #imageLiteral(resourceName: "filter_filled")
        } else {
            sortButton.image = #imageLiteral(resourceName: "filter_empty")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = searchTerm
        self.searchField.delegate = self
        loadRecords(searchString: searchTerm)
    }
    
    //MARK: - Preparatory Functions
    internal func loadRecords(searchString: String) {
        let escapedString = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        APIRequestManager.manager.getData(endPoint: "http://www.vam.ac.uk/api/json/museumobject/search?q=\(escapedString!)") { (data) in
            if data != nil {
                if let records = Record.getRecords(from: data!) {
                    print("We've got Records! \(records.count)")
                    self.records = records
                    self.countLocations()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    internal func countLocations() {
        locationDict = [String : Int]()
        locationArray = [String]()
        for all in records {
            locationDict[all.place] = 0
        }
        
        locationArray = Array(locationDict.keys).sorted { $0 < $1 }
        print("\n\n\nLocation dict: \(locationDict.count)")
        print("\nLocation Array: \(locationArray)")
    }
    
    func sortRecords(at indexPath: IndexPath, sorted: Bool) -> Record {
        if sorted {
            let recordsByLocation = records.filter { (record) -> Bool in
                (record.place) == locationArray[indexPath.section]
                }.sorted { $0.object < $1.object }
            return recordsByLocation[indexPath.row]
        } else {
            return records.sorted { $0.object < $1.object } [indexPath.row]
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if sorted {
            return locationDict.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sorted {
            let recordsByLocation = records.filter { $0.place == locationArray[section] }
            return recordsByLocation.count
        } else {
            return records.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard sorted else { return nil }
        return "\(locationArray[section])"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath)
        var record: Record?
        
        record = sortRecords(at: indexPath, sorted: sorted)
        
        if let recordFixed = record {
            var recordLabelTextString = "\(recordFixed.object), \(recordFixed.date)"
            if recordFixed.place != "" {
                recordLabelTextString += " - \(recordFixed.place)"
            }
            cell.textLabel?.text = recordLabelTextString
            cell.detailTextLabel?.text = recordFixed.title
            
            APIRequestManager.manager.getData(endPoint: recordFixed.imageSmall ) { (data: Data?) in
                if  let validData = data,
                    let validImage = UIImage(data: validData) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = validImage
                        cell.setNeedsLayout()
                    }
                }
            }
        }
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tappedRecordCell: UITableViewCell = sender as? UITableViewCell {
            if segue.identifier == "recordSegue" {
                let recordViewController: RecordViewController = segue.destination as! RecordViewController
                let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedRecordCell)!
                
                recordViewController.recordSelected = sortRecords(at: cellIndexPath, sorted: sorted)
                
                // The below affects the title of the back button in the next view controller
                let backItem = UIBarButtonItem()
                backItem.title = "Back to \"\(searchTerm)\""
                navigationItem.backBarButtonItem = backItem
            }
        }
    }
    
    // MARK: - Textfield Stuff
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if let search = searchField.text {
            searchTerm = search
            self.title = searchTerm
            loadRecords(searchString: search)
        }
        return true
    }
}
