//
//  TableViewController.swift
//  VictoriaAlbert
//
//  Created by Marty Avedon on 11/10/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import UIKit

let endPoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=skull"

class TableViewController: UITableViewController {
    
    var selectedBric: BricABrac?
    var bricArr:[BricABrac]? = [BricABrac]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Skulls"
        loadBricABrac(searchString: endPoint)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let asManyCellsAsWeNeed = bricArr {
            return asManyCellsAsWeNeed.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BricABracCell", for: indexPath)
        
        if let titleOfCell = bricArr?[indexPath.row].title {
            cell.textLabel?.text = titleOfCell
        } else {
            cell.textLabel?.text = "Unknown"
        }
        
        if let subtitleOfCell = bricArr?[indexPath.row].title {
            cell.detailTextLabel?.text = subtitleOfCell
        } else {
            cell.detailTextLabel?.text = ""
        }
        
        /*
        if let imgString = bricArr?[indexPath.row].pic.thumbPic {
            cell.imageView?.image = UIImage(named: imgString)
        } else {
            cell.imageView?.image = UIImage(named: "https://s13.postimg.org/hhet1hesn/placeholder.png")
        }
        */
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadBricABrac(searchString: String) {
        APIRequestManager.manager.getData(endPoint: "http://www.vam.ac.uk/api/json/museumobject/search?q=skull") { (data) in
            if data != nil {
                
                if BricABrac.makeBricArr(from: data!) != nil {
                    print("#####################We've got Records! \(self.bricArr?.count)")
//                    self.bricArr = bricArr
//                    self.countLocations()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("###################################### We have a problem ##############################")
                }
            }
        }
    }
}
