//
//  VictoriaAlbertTableViewController.swift
//  VictoriaAlbert
//
//  Created by Amber Spadafora on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class VictoriaAlbertTableViewController: UITableViewController {
    
    internal var photos: [Photo] = []
    internal var apiEndPoint: URL = URL(string: "http://www.vam.ac.uk/api/json/museumobject/search?q=ring")!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //lines 20-27 pull data from the apiEndPoint and then create an array of results
        ApiManager.manager.getData(endPointUrl: apiEndPoint, callback: { (data) in
            guard let validData = data else {
                print("Api Request for data was unsuccessful")
                return
            }
            guard let parsedPhotos = PhotoFactory.manager.getPhotoData(from: validData) else { return }
            DispatchQueue.main.async {
                self.photos = parsedPhotos
                self.tableView.reloadData()
            }
            
        })
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCellID", for: indexPath) as! PhotoTableViewCell

        let photoInfo = self.photos[indexPath.row]
        cell.setData(photos: photoInfo)
            

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tappedPhotoCell: PhotoTableViewCell = sender as? PhotoTableViewCell {
            if segue.identifier == "detailSegue" {
                let destination: DetailViewController = segue.destination as! DetailViewController
                let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedPhotoCell)!
                
                
                let selectedPhoto: Photo = photos[cellIndexPath.row]
                destination.photo = selectedPhoto
            }
        }
    }
 




}
