//
//  ObjectTableViewCell.swift
//  VictoriaAlbert
//
//  Created by Tong Lin on 11/10/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import UIKit

class ObjectTableViewCell: UITableViewCell {

    @IBOutlet weak var smallimage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
