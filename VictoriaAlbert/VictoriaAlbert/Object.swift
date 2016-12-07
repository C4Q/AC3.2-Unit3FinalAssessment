//
//  Object.swift
//  VictoriaAlbert
//
//  Created by Ana Ma on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

enum ObjectModelParseError : Error {
    case dictionary
    case records
    case fields
    case primary_image_id
    case rights
    case year_start
    case object_number
    case artist
    case museum_number
    case object
    case longitude
    case last_processed
    case event_text
    case place
    case location
    case last_checked
    case museum_number_token
    case latitude
    case title
    case date_text
    case slug
    case sys_update
    case collection_code
}

class Object {
    let primary_image_id : String
    let rights : Int
    let year_start: Int
    let object_number: String
    let artist: String
    let museum_number: String
    let object : String
    //let longitude: String
    let last_processed: String
    let event_text: String
    let place: String
    let location: String
    let last_checked : String
    let museum_number_token : String
    //let latitude : String
    let title : String
    let date_text : String
    let slug : String
    let sys_updated: String
    let collection_code: String
    var imageURLString: String? { //Computed Property
        //Source: http://stackoverflow.com/questions/24044851/how-do-you-use-string-substringwithrange-or-how-do-ranges-work-in-swift
        if primary_image_id.characters.count >= 6 {
            let str = primary_image_id
            //One way of getting first 6 characters
            let startIndex = str.index(str.startIndex, offsetBy: 0)
            let endIndex = str.index(str.startIndex, offsetBy: 5)
            let imageSetString =  str[startIndex...endIndex]
            
            //Second way of getting first 6 characters
            let first6charOfStr = String(str.characters.prefix(6))
            
            return "http://media.vam.ac.uk/media/thira/collection_images/\(first6charOfStr)/\(primary_image_id)_jpg_o.jpg"
        } else {
//            return "http://media.vam.ac.uk/media/thira/collection_images/\(primary_image_id)/\(primary_image_id)_jpg_o.jpg"
            return nil
        }
    }
    
    var imageLargeURLString: String? {
        if primary_image_id.characters.count >= 6 {
            let str = primary_image_id
            let startIndex = str.index(str.startIndex, offsetBy: 0)
            let endIndex = str.index(str.startIndex, offsetBy: 5)
            let imageSetString =  str[startIndex...endIndex]
            return "http://media.vam.ac.uk/media/thira/collection_images/\(imageSetString)/\(primary_image_id).jpg"
        } else {
//            return "http://media.vam.ac.uk/media/thira/collection_images/\(primary_image_id)/\(primary_image_id).jpg"
            return nil
        }
    }
    
    init (primary_image_id : String,
          rights : Int,
          year_start: Int,
          object_number: String,
          artist: String,
          museum_number: String,
          object : String,
        //longitude: String,
        last_processed: String,
        event_text: String,
        place: String,
        location: String,
        last_checked : String,
        museum_number_token : String,
        //latitude : String,
        title : String,
        date_text : String,
        slug : String,
        sys_updated: String,
        collection_code: String) {
        self.primary_image_id = primary_image_id
        self.rights = rights
        self.year_start = year_start
        self.object_number = object_number
        self.artist = artist
        self.museum_number = museum_number
        self.object = object
        //self.longitude = longitude
        self.last_processed = last_processed
        self.event_text = event_text
        self.place = place
        self.location = location
        self.last_checked = last_checked
        self.museum_number_token = museum_number_token
        //self.latitude = latitude
        self.title = title
        self.date_text = date_text
        self.slug = slug
        self.sys_updated = sys_updated
        self.collection_code = collection_code
    }
    
    convenience init?(dict:[String:Any]) throws {
        guard let fields = dict["fields"] as? [String: Any] else {
            throw ObjectModelParseError.fields
        }
        let primary_image_id = fields["primary_image_id"] as? String
        guard let rights = fields["rights"] as? Int else {
            throw ObjectModelParseError.rights
        }
        let year_start = fields["year_start"] as? Int

        guard let object_number = fields["object_number"] as? String else {
            throw ObjectModelParseError.object_number
        }
        guard let artist = fields["artist"] as? String  else {
            throw ObjectModelParseError.artist
        }
        guard let museum_number = fields["museum_number"] as? String else {
            throw ObjectModelParseError.museum_number
        }
        guard let object = fields["object"] as? String else {
            throw ObjectModelParseError.object
        }
        //guard let longtitude = fields["longitude"] as? String else {
        //throw ObjectModelParseError.longitude
        //}
        let last_processed = fields["last_processed"] as? String
        let event_text = fields["event_text"] as? String
        guard let place = fields["place"] as? String else {
            throw ObjectModelParseError.place
        }
        guard let location = fields["location"] as? String else {
            throw ObjectModelParseError.location
        }
        let last_checked = fields["last_checked"] as? String
        guard let museum_number_token = fields["museum_number_token"] as? String else {
            throw ObjectModelParseError.museum_number_token
        }
        //guard let latitude = fields["latitude"] as? String  else {
        //throw ObjectModelParseError.latitude
        //}
        guard let title = fields["title"] as? String else {
            throw ObjectModelParseError.title
        }
        guard let date_text = fields["date_text"] as? String  else {
            throw ObjectModelParseError.date_text
        }
        guard let slug = fields["slug"] as? String else {
            throw ObjectModelParseError.slug
        }
        guard let sys_updated = fields["sys_updated"] as? String else {
            throw ObjectModelParseError.sys_update
        }
        guard let collection_code = fields["collection_code"] as? String else {
            throw ObjectModelParseError.collection_code
        }
        self.init(primary_image_id: primary_image_id ?? "", rights: rights, year_start: year_start ?? 0, object_number: object_number, artist: artist, museum_number: museum_number, object: object, last_processed: last_processed ?? "", event_text: event_text ?? "", place: place, location: location, last_checked: last_checked ?? "", museum_number_token: museum_number_token, title: title, date_text: date_text, slug: slug, sys_updated: sys_updated, collection_code: collection_code)
    }
    
    static func getCollectionObject (from data: Data) -> [Object]? {
        var objectArray = [Object]()
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            guard let dictionary = jsonData as? [String: Any] else {
                throw ObjectModelParseError.dictionary
            }
            guard let records = dictionary["records"] as? [[String:Any]] else {
                throw ObjectModelParseError.records
            }
            try records.forEach({ (record) in
                guard let o = try Object(dict: record) else { return }
                objectArray.append(o)
            })
        }
        catch {
            print(error)
        }
        return objectArray
    }
}

/*
 {
 "pk": 34197,
 "model": "collection.museumobject",
 "fields": {
 "primary_image_id": "2009CT3900",
 "rights": 3,
 "year_start": 1600,
 "object_number": "O39115",
 "artist": "Unknown",
 "museum_number": "846 to M-1890",
 "object": "House front",
 "longitude": "-0.12714000",
 "last_processed": "2016-10-28 20:17:07",
 "event_text": "",
 "place": "London",
 "location": "Medieval and Renaissance, room 64b, case WW",
 "last_checked": "2016-10-28 20:17:07",
 "museum_number_token": "8461890",
 "latitude": "51.50632100",
 "title": "Sir Paul Pindar's House",
 "date_text": "1600 (made)",
 "slug": "sir-paul-pindars-house-house-front-unknown",
 "sys_updated": "2014-12-02 00:00:00",
 "collection_code": "FWK"
 }
 },
 */
