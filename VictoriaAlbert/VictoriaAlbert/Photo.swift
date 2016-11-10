//
//  Photo.swift
//  VictoriaAlbert
//
//  Created by Amber Spadafora on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class Photo {

    var photoID: String
    var object: String // example: "object": "Gimmel ring"
    var date: String
    var place: String
    var title: String
    
    init(photoID: String, object: String, date: String, place: String, title: String) {
        
        self.photoID = photoID
        self.object = object
        self.date = date
        self.place = place
        self.title = title
    }
    
    convenience init?(from dictionary: [String: Any]) {
        if let object = dictionary["object"] as? String,
            let date = dictionary["date_text"] as? String,
            let place = dictionary["place"] as? String,
            let title = dictionary["title"] as? String,
            let photoID = dictionary["primary_image_id"] as? String {
                self.init(photoID: photoID, object: object, date: date, place: place, title: title)
        } else {
            return nil
        }
        
    }
    
    func createSmallImageUrl(photoID: String) -> String {
        let firstSixChars: String = String(photoID.characters.prefix(6))
        
        
        let imageBaseUrlString: String = "http://media.vam.ac.uk/media/thira/collection_images/"
        
        let imageIdUrlAddOn: String = "\(photoID + "_jpg_o.jpg")"
        let smallImageUrlString: String = imageBaseUrlString + (firstSixChars + "/") + imageIdUrlAddOn
        
        return smallImageUrlString
        
       // http://media.vam.ac.uk/media/thira/collection_images/2006AM/2006AM3589_jpg_o.jpg
        
    }
    
  //  http://media.vam.ac.uk/media/thira/collection_images/2006AM/2006AM6763.jpg
    
    func createLargemageUrl(photoID: String) -> String {
        let firstSixChars: String = String(photoID.characters.prefix(6))
        
        
        let imageBaseUrlString: String = "http://media.vam.ac.uk/media/thira/collection_images/"
        
        let imageIdUrlAddOn: String = "\(photoID + ".jpg")"
        let largeImageUrlString: String = imageBaseUrlString + (firstSixChars + "/") + imageIdUrlAddOn
        
        return largeImageUrlString
        
    }
    
    
    
    
}


/*
 
 Collection object images are served from this location.
 
 http://media.vam.ac.uk/media/thira/collection_images/
 The second part of the URL is constructed from the first 6 characters of the image id.
 
 http://media.vam.ac.uk/media/thira/collection_images/2007BL/
 The final part of the URL is the image id with a jpg extension - at its most simple...
 
 http://media.vam.ac.uk/media/thira/collection_images/2007BL/2007BL8769.jpg
 
 records is an array of dictionaries [[String:AnyObject]]
 
 fields can be located by records["fields"] and is a dictionary, within a dictionary
 
 so to access rawValues within "fields" you would have to do a call such as
 
 records["fields"]["primary_image_id"]
 
 records: [
 {
 "pk": 8757,
 "model": "collection.museumobject",
 "fields": {
    "primary_image_id": "2006AM3589",
    "rights": 3,
    "year_start": 1595,
    "object_number": "O77755",
    "artist": "Unknown",
    "museum_number": "851-1871",
    "object": "Gimmel ring",
    "longitude": "10.45424000",
    "last_processed": "2016-10-28 19:04:41",
    "event_text": "",
    "place": "Germany",
    "location": "British Galleries, room 58c, case 5",
    "last_checked": "2016-10-28 19:04:41",
    "museum_number_token": "8511871",
    "latitude": "51.09083900",
    "title": "",
    "date_text": "ca.1600 (made)",
    "slug": "gimmel-ring-unknown",
    "sys_updated": "2015-03-02 00:00:00",
    "collection_code": "MET"
    }
 },
 */
