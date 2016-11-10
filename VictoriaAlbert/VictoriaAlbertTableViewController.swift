//
//  VictoriaAlbertTableViewController.swift
//  VictoriaAlbert
//
//  Created by Edward Anchundia on 11/10/16.
//  Copyright © 2016 Edward Anchundia. All rights reserved.
//

import UIKit

class VictoriaAlbertTableViewController: UITableViewController {

    var victoriaAlbert: [VictoriaAlbert] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    func loadData() {
        APIRequestManager.manager.getData(endPoint: "http://www.vam.ac.uk/api/json/museumobject/search?q=ring") { (data: Data?) in
            if data != nil {
                if let victoriaAlbertData = VictoriaAlbert.getVictoriaAlbert(from: data!) {
                    DispatchQueue.main.async {
                        self.victoriaAlbert = victoriaAlbertData
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return victoriaAlbert.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VictoriaAlbertCell", for: indexPath)
        
        let victoriaAlberts = victoriaAlbert[indexPath.row]
        let firstSix = String(victoriaAlberts.imageID.characters.prefix(6))
        
        cell.textLabel?.text = victoriaAlberts.object + ", " + victoriaAlberts.dateText + ", " + victoriaAlberts.place
        cell.detailTextLabel?.text = victoriaAlberts.title
        cell.imageView?.downloadImage(urlString: "http://media.vam.ac.uk/media/thira/collection_images/\(firstSix)/\(victoriaAlberts.imageID)_jpg_o.jpg")
        

        return cell
    }
    
    
//    func getImage() {
//        victoriaAlbert.spl
//    }

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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let avc = segue.destination as? VictoriaAlbertPictureViewController,
//            let cell = sender as? UITableViewCell,
//            let indexPath = tableView.indexPath(for: cell) {
//            avc. = victoriaAlbert[indexPath.row]
//        }
//    }


}
