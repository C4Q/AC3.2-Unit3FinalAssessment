//
//  VAMTableViewController.swift
//  VictoriaAlbert
//
//  Created by Karen Fuentes on 11/10/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import UIKit

class VAMTableViewController: UITableViewController {

    var records = [Record]()
    var rec: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRecords()
    }
    
    
    
    
    func loadRecords() {
        let recordEndpoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=ring"
        APIRequestManager.manager.getData(endPoint: recordEndpoint) { (data:Data?) in
            if data != nil {
                if let recordInfo = Record.getRecords(from:data!){
                   self.records = recordInfo
                    DispatchQueue.main.async {
                        self.tableView?.reloadData()
                    }
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
        return records.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "VAMRecordCell", for: indexPath) as!VAMTableViewCell
        let recordObject = records[indexPath.row]
        cell.recordDetail.text = "\(recordObject.object),\(recordObject.date_Text) - \(recordObject.place)"
        let thumbImage = recordObject.imageID
        let thePartialID = thumbImage.startIndex..<thumbImage.index(thumbImage.startIndex, offsetBy: 6)
        let thumbImageIDWithSix = thumbImage[thePartialID]
        let thumbImageURL = "http://media.vam.ac.uk/media/thira/collection_images/\(thumbImageIDWithSix)/\(thumbImage)_jpg_o.jpg"

        APIRequestManager.manager.getImage(urlString: thumbImageURL) { (validdata:Data) in
            DispatchQueue.main.async {
                cell.thumbImage.image = UIImage(data: validdata)
    
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let randomSelectedRecord = records[indexPath.row]
        performSegue(withIdentifier: "showLargeImage" , sender: randomSelectedRecord)
    }
    
    



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLargeImage" {
            if let destination = segue.destination as? VAMDetailViewController {
                destination.recordThatWasSelected = sender as! Record?
            }
        }

    }


}
