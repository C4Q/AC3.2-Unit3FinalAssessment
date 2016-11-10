//
//  MuseumObject.swift
//  VictoriaAlbert
//
//  Created by Marcel Chaucer on 11/10/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import Foundation

class MuseumObject {
    let object: String
    let place: String
    let date: String
    let title: String
    let imageID: String
    
    init(object: String, place: String, date: String, title: String, imageID: String) {
    self.object = object
    self.place = place
    self.date = date
    self.title = title
    self.imageID = imageID
    
}
    convenience init?(withDict dict: [String:Any]) {
        if let fields = dict["fields"] as? [String: Any],
        let object = fields["object"] as? String,
        let place = fields["place"] as? String,
        let date = fields["date_text"] as? String,
        let title = fields["title"] as? String,
        let imageID = fields["primary_image_id"] as? String
        
        {
            self.init(object: object, place: place, date: date, title: title, imageID: imageID)
        }
        else {
            return  nil
        }
    }
    
    
    static func objects(from data: Data) -> [MuseumObject]? {
        var objectsToReturn: [MuseumObject]? = []
        
        do {
            let jsonData: Any = try? JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [String : AnyObject] = jsonData as? [String : AnyObject],
                let records = response["records"] as? [[String: AnyObject]] else {return nil}
            
            for objects in records {
                if let object = try MuseumObject(withDict: objects) {
                    objectsToReturn?.append(object)
                }
            }
        }
        catch {
            print("Unknown parsing error")
        }
        return objectsToReturn
        
    }
}
