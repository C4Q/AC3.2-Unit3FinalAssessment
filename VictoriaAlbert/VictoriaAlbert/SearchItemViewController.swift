//
//  SearchItemViewController.swift
//  VictoriaAlbert
//
//  Created by Sabrina Ip on 11/10/16.
//  Copyright © 2016 Sabrina. All rights reserved.
//

import UIKit

class SearchItemViewController: UIViewController, UITextFieldDelegate {
    
    var searchItem = ""
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Victoria and Albert Museum"
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let searchString = searchTextField.text else { return }
        searchItem = searchString
        guard searchItem != "" else { return }
        performSegue(withIdentifier: "SegueToMOTVC", sender: searchItem)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SegueToMOTVC" {
            if let destinationVC = segue.destination as? MuseumObjectTableViewController {
                destinationVC.searchText = searchItem
            }
        }

    }

}
