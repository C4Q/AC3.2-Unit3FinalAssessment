//
//  BricABrac.swift
//  VictoriaAlbert
//
//  Created by Marty Avedon on 11/10/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import Foundation

class BricABrac {
    let title: String // Cell titles should be constructed from {object}, {date_text} - {place}, for example
    let subtitle: String // From title field
    let pic: Pic
    let endpoint = "http://www.vam.ac.uk/api/json/museumobject/search?q=skull"
    
    init(title: String, subtitle: String, pic: Pic) {
        self.title = title
        self.subtitle = subtitle
        self.pic = pic
    }
}
