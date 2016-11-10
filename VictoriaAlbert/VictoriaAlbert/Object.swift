//
//  File.swift
//  VictoriaAlbert
//
//  Created by Tong Lin on 11/10/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import Foundation

class Object{
    /*{
     pk: 8757,
     model: "collection.museumobject",
     fields: {
     primary_image_id: "2006AM3589",
     rights: 3,
     year_start: 1595,
     object_number: "O77755",
     artist: "Unknown",
     museum_number: "851-1871",
     object: "Gimmel ring",
     longitude: "10.45424000",
     last_processed: "2016-10-28 19:04:41",
     event_text: "",
     place: "Germany",
     location: "British Galleries, room 58c, case 5",
     last_checked: "2016-10-28 19:04:41",
     museum_number_token: "8511871",
     latitude: "51.09083900",
     title: "",
     date_text: "ca.1600 (made)",
     slug: "gimmel-ring-unknown",
     sys_updated: "2015-03-02 00:00:00",
     collection_code: "MET"
     }
     },*/
    
    let imageID: String
    let artist: String
    let object: String
    let place: String
    let location: String
    let sys_updated: String
    let year_start: Int
    let object_number: String
    
    init(imageID: String, artist: String, object: String, place: String, location: String, sys_updated: String, year_start: Int, object_number: String){
        self.imageID = imageID
        self.artist = artist
        self.object = object
        self.place = place
        self.location = location
        self.sys_updated = sys_updated
        self.year_start = year_start
        self.object_number = object_number
    }
    
    static func setObject(from data: Data) -> [Object]?{
        var finalObjects: [Object] = []
        do {
            let rawData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let validData: [String: AnyObject] = rawData as? [String: AnyObject],
                let objects: [AnyObject] = validData["records"] as? [AnyObject] else{
                    return nil
            }
            
            objects.forEach({ (obj) in
                guard let fields: [String: Any] = obj["fields"] as? [String: Any] else{
                    return
                }
                
                guard let imageID: String = fields["primary_image_id"] as? String else{
                    return
                }
                
                guard let artist: String = fields["artist"] as? String else {
                    return
                }
                
                guard let object: String = fields["object"] as? String else {
                    return
                }
                
                guard let place: String = fields["place"] as? String else {
                    return
                }
                
                guard let location: String = fields["location"] as? String else {
                    return
                }
                
                guard let sys_updated: String = fields["sys_updated"] as? String else {
                    return
                }
                
                guard let year_start: Int = fields["year_start"] as? Int else {
                    return
                }
                
                guard let object_number: String = fields["object_number"] as? String else{
                    return
                }
                
                let temp: Object = Object.init(imageID: imageID, artist: artist, object: object, place: place, location: location, sys_updated: sys_updated, year_start: year_start, object_number: object_number)
                
                finalObjects.append(temp)
            })
            
            return finalObjects
        } catch {
            print(" ")
        }
        
        return nil
    }
    
    
    
    
    
}
