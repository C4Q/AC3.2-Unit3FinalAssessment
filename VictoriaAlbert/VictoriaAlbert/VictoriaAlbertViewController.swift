//
//  ViewController.swift
//  VictoriaAlbert
//
//  Created by Ilmira Estil on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit
//CHECK
fileprivate let endpoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=ring"


class VictoriaAlbertTableViewController: UITableViewController {
    var museum: Museum?
    var museumFields = [Museum]()
    var detailImgOfCell = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMusem(apiEndpoint: endpoint)
        
    }
    
    func loadMusem(apiEndpoint: String) {
        APIRequestManager.manager.getData(endPoint: apiEndpoint) { (data: Data?) in
            if let validData = data,
                let validMuseum = Museum.buildMuseum(from: validData) {
                self.museumFields = validMuseum
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    //MARK: - TableView funcs
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return museumFields.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VaCell", for: indexPath)
        if let vaCell = cell as? VATableViewCell {
            let selectedCell = museumFields[indexPath.row]
            
            vaCell.vaLabel?.text = "\(selectedCell.object), \(selectedCell.date), \(selectedCell.place)"
            
            
            //GETTING IMAGE DATA ************** 2007BM/2007BM5536_jpg_o.jpg"
            let imageEndpoint = "http://media.vam.ac.uk/media/thira/collection_images/\(selectedCell.imageIdShort)/\(selectedCell.imageId)_jpg_o.jpg"
            
            APIRequestManager.manager.getData(endPoint: imageEndpoint, callback: { (data: Data?) in
                guard let unwrappedImageData = data else { return }
                DispatchQueue.main.async {
                    vaCell.vaImage?.image = UIImage(data: unwrappedImageData)
                    vaCell.setNeedsLayout()
                }
            })
            
            
        }
        return cell
    }
    
    //Segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = museumFields[indexPath.row]
        detailImgOfCell = "http://media.vam.ac.uk/media/thira/collection_images/\(selectedCell.imageIdShort)/\(selectedCell.imageId).jpg"
        self.performSegue(withIdentifier: "vaSegue", sender: selectedCell)
    }
    
    //MARK: - Segue to DetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "vaSegue" {
            if let vc = segue.destination as? DetailViewController {
                vc.detailMuseumField = museumFields
                vc.detailImgEndpoint = detailImgOfCell
            }
        }
    }
}

