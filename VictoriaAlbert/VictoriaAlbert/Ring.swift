//
//  Ring.swift
//  VictoriaAlbert
//
//  Created by Eashir Arafat on 11/14/16.
//  Copyright © 2016 Evan. All rights reserved.
//

import Foundation

enum RingParseError: Error {
    case response, fields, object, dateText, place, title, yearStart, imageID, museumNumber, location
}

class Ring {
    let object: String
    let dateText: String
    let place: String
    let title: String
    let yearStart: Int
    let imageID: String
    let museumNumber: String
    let location: String
    
    init(object: String, dateText: String, place: String, title: String, yearStart: Int, imageID: String, museumNumber: String, location: String) {
        
        self.object = object
        self.dateText = dateText
        self.place = place
        self.title = title
        self.yearStart = yearStart
        self.imageID = imageID
        self.museumNumber = museumNumber
        self.location = location
    }
    
    static func getRings(from data: Data) -> [Ring]? {
        var Rings: [Ring]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response = jsonData as? [String: Any],
                let records = response["records"] as? [[String: Any]]
                else { throw RingParseError.response }
            
            for each in records {
                
                guard let fields = each["fields"] as? [String: Any]
                    else { throw RingParseError.fields }
                
                guard let object = fields["object"] as? String
                    else { throw RingParseError.object }
                
                guard let dateText = fields["date_text"] as? String
                    else { throw RingParseError.dateText }
                
                guard let place = fields["place"] as? String
                    else { throw RingParseError.place }
                
                guard let title = fields["title"] as? String
                    else { throw RingParseError.title }
                
                guard let yearStart = fields["year_start"] as? Int
                    else { throw RingParseError.yearStart }
                
                guard let imageID = fields["primary_image_id"] as? String
                    else { throw RingParseError.imageID }
                
                guard let museumNumber = fields["museum_number"] as? String
                    else { throw RingParseError.museumNumber }
                
                guard let location = fields["location"] as? String
                    else { throw RingParseError.location }
                
                let validObject = Ring(object: object,
                                       dateText: dateText,
                                       place: place,
                                       title: title,
                                       yearStart: yearStart,
                                       imageID: imageID,
                                       museumNumber: museumNumber,
                                       location:  location)
                
                Rings?.append(validObject)
            }
            return Rings
        }
        catch {
            print("error: \(error)")
        }
        
        return nil
    }
}
