//
//  TableViewController.swift
//  Unit3FinalAssessment
//
//  Created by Eric Chang on 11/10/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var museumObjects = [MuseumObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewEndpoint(endPoint: "http://www.vam.ac.uk/api/json/museumobject/search?q=ring")
    }

    func tableViewEndpoint(endPoint: String) {
        APIRequestManager.manager.getData(endPoint: "\(endPoint)") { (data: Data?) in
            if  let validData = data,
                let validObjects = MuseumObject.objects(from: validData) {
                self.museumObjects = validObjects
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
    }


    // MARK: - Table view data source
    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return museumObjects.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectCell", for: indexPath) as! TableViewCell

        let object = self.museumObjects[indexPath.row]
        cell.objectTitleLabel.text = "\(object.object) \(object.dateText) \(object.place)"
        cell.objectSubtitleLabel.text = object.title
        
        let image = object.imageID
        let firstSixIndex = image.startIndex..<image.index(image.startIndex, offsetBy: 6)
        let firstSix = image[firstSixIndex]
        let imageURL = "http://media.vam.ac.uk/media/thira/collection_images/\(firstSix)/\(image)_jpg_o.jpg"
        APIRequestManager.manager.downloadImage(urlString: imageURL) { (returnedData: Data) in
            DispatchQueue.main.async {
                cell.objectImageView.image = UIImage(data: returnedData)
                cell.setNeedsLayout()
            }
        }

        return cell
    }
    
    
    // MARK: - Navigation
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let objectVC = segue.destination as? DetailViewController,
            let cell = sender as? TableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            objectVC.thisObject = museumObjects[indexPath.row]
        }
    }

}
