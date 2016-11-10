//
//  MuseumObject.swift
//  VictoriaAlbert
//
//  Created by Erica Y Stevens on 11/10/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import Foundation

class MuseumObject {
    var objectName: String
    var place: String
    var location: String
    var dateText: String
    var imageID: String
    var title: String
    var artist: String
    var yearStart: Int
    
    init(objectName: String, place: String, location: String, dateText: String, imageID: String, title: String, artist: String, yearStart: Int) {
        self.objectName = objectName
        self.place = place
        self.location = location
        self.dateText = dateText
        self.imageID = imageID
        self.title = title
        self.artist = artist
        self.yearStart = yearStart
    }
    
    convenience init?(fromDict dict: [String:Any]) {
        if let objectName = dict["object"] as? String, let place = dict["place"] as? String, let location = dict["location"] as? String, let dateText = dict["date_text"] as? String, let imageID = dict["primary_image_id"] as? String, let title = dict["title"] as? String, let artist = dict["artist"] as? String, let yearStart = dict["year_start"] as? Int{
            self.init(objectName: objectName, place: place, location: location, dateText: dateText, imageID: imageID, title: title, artist: artist, yearStart: yearStart)
        } else {
            return nil
        }
    }
}
