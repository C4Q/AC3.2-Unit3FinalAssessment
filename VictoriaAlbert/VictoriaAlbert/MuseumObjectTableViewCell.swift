//
//  MusuemObjectTableViewCell.swift
//  VictoriaAlbert
//
//  Created by Erica Y Stevens on 11/10/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import UIKit

class MuseumObjectTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var museumObjectImageView: UIImageView!
    @IBOutlet weak var museumObjectTitleLabel: UILabel!
    @IBOutlet weak var museumObjectSubtitleLabel: UILabel!
    

    // MARK: Built-In Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

    // MARK: Extensions

//Note: I understand the concept of MVC (finally!), but when I tried to put this extension into its own file, I kept getting errors
extension UIImageView {

    func loadImageUsing(url: URL) {
        let session = URLSession(configuration: URLSessionConfiguration.default)

        session.dataTask(with: url) { (data: Data?, urlResponse: URLResponse?, error: Error?) in

            if error != nil {
                print("Error: \(error)")
            }

            if let validData = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: validData)
                }
            }  else {
                print("Method Unsuccessful: loadImageUsing(url:)")
            }
            }.resume()
    }
}
