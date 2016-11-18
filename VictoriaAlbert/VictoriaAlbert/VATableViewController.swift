//
//  VATableViewController.swift
//  VictoriaAlbert
//
//  Created by Annie Tung on 11/10/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import UIKit

class VATableViewController: UITableViewController, UISearchBarDelegate {
    
    var victoriaAlbert: [VictoriaAlbert] = []
    let endPoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=ring"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Victoria and Albert Museum"
        getVictoriaAlbertApi()
        searchBar()
    }
    
    // MARK: - Method
    func getVictoriaAlbertApi() {
        APIRequestManager.manager.getData(apiEndPoint: endPoint) { (data: Data?) in
            guard let validData = data else { return }
            dump(validData)
            
            if let validVA = VictoriaAlbert.parseData(data: validData) {
                self.victoriaAlbert = validVA
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
        func searchBar() {
            let searchBar = UISearchBar()
            searchBar.showsCancelButton = false
            searchBar.placeholder = "Enter your search here"
            searchBar.delegate = self
            self.navigationItem.titleView = searchBar
        }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return victoriaAlbert.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VictoriaAlbertCell", for: indexPath)

        let va = victoriaAlbert[indexPath.row]
        cell.textLabel?.text = "\(va.object), \(va.dateText), \(va.place)"
        cell.detailTextLabel?.text = va.title
       
        APIRequestManager.manager.getData(apiEndPoint: va.thumbnailImageURLString) { (data: Data?) in
            if  let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    cell.imageView?.image = validImage
                    cell.setNeedsLayout()
                }
            }
        }
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? VAViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            destinationVC.victoria = victoriaAlbert[indexPath.row]
        }
    }
    
    
}
