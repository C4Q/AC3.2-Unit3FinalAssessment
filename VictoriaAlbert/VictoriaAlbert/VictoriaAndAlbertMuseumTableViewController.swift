//
//  VictoriaAndAlbertMuseumTableViewController.swift
//  VictoriaAlbert
//
//  Created by John Gabriel Breshears on 11/10/16.
//  Copyright © 2016 John Gabriel Breshears. All rights reserved.
//

import UIKit

class VictoriaAndAlbertMuseumTableViewController: UITableViewController {
    var searchKey = "ring"
    
    
// Okay so museum now has a shit ton of values. It contains all the object,datetex,place,title,primayImageId, and location data for all ring search results.
    var museum: [Item] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        

    }

    
    func loadData() {
        
        
        
        
        
        APIRequestManager.manager.getData(searchKey: searchKey) { (data: Data?) in
            if data != nil {
                if let validData = Museum.getMuseumData(from: data!) {
                    DispatchQueue.main.async {
                        self.museum = validData
                    }
                }
                    
                }
            }
        }
    
    
//    func loadSmallPicture() {
//        APIRequestManager.manager.getLittlePicture(primaryImageId:  callback: <#T##(Data?) -> Void#>)
//    }

    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return museum.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oldStuffImeanHistory", for: indexPath)
        
        let m = museum[indexPath.row]
        
 // Why the fuck does the below code not worK? Damn, i need to review table views....
cell.textLabel?.text = m.title
        
        // Configure the cell...

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

}
