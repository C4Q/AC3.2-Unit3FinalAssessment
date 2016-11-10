//
//  MuseumObject.swift
//  Unit3FinalAssessment
//
//  Created by Eric Chang on 11/10/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import Foundation

enum MuseumObjectParseError: Error {
    case response, fields, object, dateText, place, title, imageID
}

class MuseumObject {
    internal let object: String
    internal let dateText: String
    internal let place: String
    internal let title: String
    internal let imageID: String
    
    init(object: String, dateText: String, place: String, title: String, imageID: String) {
        self.object = object
        self.dateText = dateText
        self.place = place
        self.title = title
        self.imageID = imageID
    }
    
    static func objects(from data: Data) -> [MuseumObject]? {
        var museumObjects: [MuseumObject]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response = jsonData as? [String: Any],
            let records = response["records"] as? [[String: Any]]
                else { throw MuseumObjectParseError.response }
            
            for each in records {
                
                guard let fields = each["fields"] as? [String: Any]
                    else { throw MuseumObjectParseError.fields }
                
                guard let object = fields["object"] as? String
                    else { throw MuseumObjectParseError.object }
                
                guard let dateText = fields["date_text"] as? String
                    else { throw MuseumObjectParseError.dateText }
                
                guard let place = fields["place"] as? String
                    else { throw MuseumObjectParseError.place }
                
                guard let title = fields["title"] as? String
                    else { throw MuseumObjectParseError.title }
                
                guard let imageID = fields["primary_image_id"] as? String
                    else { throw MuseumObjectParseError.imageID }
                        
                let validObject = MuseumObject(object: object,
                                               dateText: dateText,
                                               place: place,
                                               title: title,
                                               imageID: imageID)
                
                museumObjects?.append(validObject)
            }
            return museumObjects
        }
        catch {
            print("error: \(error)")
        }
        
     return nil
    }
}
