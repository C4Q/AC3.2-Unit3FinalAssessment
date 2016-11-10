//
//  ViewController.swift
//  VictoriaAlbert
//
//  Created by Tong Lin on 11/10/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    private var keyWords = String()
    private let cellIdentifier = "tableViewIdentifier"
    private let segueToDetail = "detailSegueIdentifier"
    var objects = [Object]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "Victoria and Albert Museum"
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func loadSearch(){
        APIRequestManager.manager.getObjects(keyWords: keyWords) { (objectsData: Data?) in
            if objectsData != nil{
                DispatchQueue.main.async {
                    if let objects = Object.setObject(from: objectsData!){
                        self.objects = objects
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        keyWords = searchBar.text!
        loadSearch()
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ObjectTableViewCell
        let holder = objects[indexPath.row]
        cell.titleLabel.text = holder.object
        cell.locationLabel.text = holder.place
        cell.smallimage.image = nil
        APIRequestManager.manager.downloadImage(imageID: holder.imageID, switchPic: 0) { (imageData: Data?) in
            if imageData != nil{
                DispatchQueue.main.async {
                    cell.smallimage.image = UIImage(data: imageData!)
                }
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToDetail {
            if let dest = segue.destination as? DetailViewController,
                
                let indexPath = tableView.indexPathForSelectedRow {
                dest.object = objects[indexPath.row]
            }
        }
    }

}

