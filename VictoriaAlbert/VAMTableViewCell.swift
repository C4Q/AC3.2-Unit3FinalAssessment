//
//  VAMTableViewCell.swift
//  VictoriaAlbert
//
//  Created by Karen Fuentes on 11/10/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import UIKit

class VAMTableViewCell: UITableViewCell {

    @IBOutlet weak var recordDetail: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
    thumbImage = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
