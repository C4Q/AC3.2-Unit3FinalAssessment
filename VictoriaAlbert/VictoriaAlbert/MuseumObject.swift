//
//  MuseumObject.swift
//  VictoriaAlbert
//
//  Created by Madushani Lekam Wasam Liyanage on 11/10/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation


enum MuseumObjectsModelParseError: Error {
    case results(json: Any)
}

class MuseumObject {
    
    let objectName: String
    let dateText: String
    let placeName: String
    let titleField: String
    let imageString: String
    let location: String
    
    
    init(objectName: String, dateText: String, placeName: String, titleField: String, imageString: String, location: String) {
        self.objectName = objectName
        self.dateText = dateText
        self.placeName = placeName
        self.titleField = titleField
        self.imageString = imageString
        self.location = location
    }
    
    convenience init?(from dictionary: [String:AnyObject]) throws {
        
        if let objectName = dictionary["object"] as? String,
            let dateText = dictionary["date_text"] as? String,
            let placeName = dictionary["place"] as? String,
            let titleField = dictionary["title"] as? String,
            let imageString = dictionary["primary_image_id"] as? String,
            let location = dictionary["location"] as? String {
            
            
            self.init(objectName: objectName, dateText: dateText, placeName: placeName, titleField: titleField, imageString: imageString, location: location)
        }
        else {
            return nil
        }
    }
    /*
     records: [
     {
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
     }
     */
    
    static func getMuseumObjects(from data: Data) -> [MuseumObject]? {
        var museumObjectsToReturn: [MuseumObject]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [String:AnyObject] = jsonData as? [String:AnyObject],
                let museumArray: [[String : AnyObject]] = response["records"] as? [[String:AnyObject]]  else {
                    throw MuseumObjectsModelParseError.results(json: jsonData)
            }
                
            for museumDict in museumArray {
                if let museumObjectsDict: [String: AnyObject] = museumDict["fields"] as? [String: AnyObject]{
                    if let object = try MuseumObject(from: museumObjectsDict) {
                        museumObjectsToReturn?.append(object)
                    }
                }
            }

        }
            
        catch let MuseumObjectsModelParseError.results(json: json)  {
            print("Error encountered with parsing 'records' key for object: \(json)")
        }
   
        catch {
            print("Unknown parsing error")
        }
        
        return museumObjectsToReturn
    }
    
    
}






