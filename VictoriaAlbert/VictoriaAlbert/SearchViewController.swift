//
//  SearchViewController.swift
//  VictoriaAlbert
//
//  Created by Madushani Lekam Wasam Liyanage on 11/10/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func searchButtonTapped(_ sender: Any) {
        
        searchText = searchTextField.text
        performSegue(withIdentifier: "SearchSegueIdentifier", sender: searchText)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "SearchSegueIdentifier" {
            if let movc = segue.destination as? MuseumObjectsTableViewController {
                movc.searchKeyword = searchText
            }
        }
        
        
    }
    

}
