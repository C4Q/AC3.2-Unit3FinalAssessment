//
//  ElementsInsideMuseum.swift
//  VictoriaAlbert
//
//  Created by John Gabriel Breshears on 11/10/16.
//  Copyright © 2016 John Gabriel Breshears. All rights reserved.
//

import Foundation

class Item {
    
    let object: String
    let date_text: String
    let place: String
    let title: String
    let primary_image_id: String
    let location: String
    
   
    init?(from dictionary: [String : Any]) {
        if let object = dictionary["object"] as? String,
        let date_text = dictionary["date_text"] as? String,
        let place = dictionary["place"] as? String,
        let title = dictionary["title"] as? String,
        let primary_image_id = dictionary["primary_image_id"] as? String,
            let location = dictionary["location"] as? String {
            self.object = object
            self.date_text = date_text
            self.place = place
            self.title = title
            self.primary_image_id = primary_image_id
            self.location = location
        }
        else {
            return nil
        }
    }
    
}

