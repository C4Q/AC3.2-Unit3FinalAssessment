//
//  MuseumObjectTableViewCell.swift
//  VictoriaAlbert
//
//  Created by Sabrina Ip on 11/10/16.
//  Copyright © 2016 Sabrina. All rights reserved.
//

import UIKit

class MuseumObjectTableViewCell: UITableViewCell {

    @IBOutlet weak var smallImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func prepareForReuse() {
        smallImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
}
