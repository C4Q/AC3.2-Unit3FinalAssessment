//
//  VictoriaAlbertTableViewController.swift
//  VictoriaAlbert
//
//  Created by Tom Seymour on 11/10/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class VictoriaAlbertTableViewController: UITableViewController, UITextFieldDelegate {
    
    var museumThings: [MuseumThing] = []
    
    let victoriaAlbertCellIdentifyer = "VictoriaAlbertCell"
    let vicAlbDetailSegueIdentifyer = "VictoriaAlbertDetailSegue"
    
    var vicAlbAPIEndpoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=ring"

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableViewData()
    }
    
    func loadTableViewData() {
        APIHelper.manager.getData(endPoint: vicAlbAPIEndpoint) { (data: Data?) in
            guard let unwrappedData = data else { return }
            self.museumThings = MuseumThing.buildMuseumThingArray(from: unwrappedData)!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let allTextFieldText = textField.text ?? "ring"
        textField.text = nil
        let searchWord = allTextFieldText.replacingOccurrences(of: " ", with: "%20")
        self.vicAlbAPIEndpoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=" + searchWord
        loadTableViewData()
        
        return true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return museumThings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: victoriaAlbertCellIdentifyer, for: indexPath)
        let thisMuseumThing = museumThings[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row + 1): \(thisMuseumThing.object), \(thisMuseumThing.dateMade), \(thisMuseumThing.placeMade)"
        cell.detailTextLabel?.text = thisMuseumThing.title
        
        APIHelper.manager.getData(endPoint: thisMuseumThing.thumbImageString) { (data: Data?) in
            
            guard let unwrappedData = data else { return }
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: unwrappedData)
                cell.setNeedsLayout()
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: vicAlbDetailSegueIdentifyer, sender: museumThings[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == vicAlbDetailSegueIdentifyer {
            if let destiationVC = segue.destination as? VictoriaAlbertDetailViewController {
                destiationVC.thisMT = sender as? MuseumThing
            }
        }
    }

}
