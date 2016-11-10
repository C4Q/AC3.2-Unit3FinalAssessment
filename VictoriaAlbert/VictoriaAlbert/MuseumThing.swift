//
//  MuseumThing.swift
//  VictoriaAlbert
//
//  Created by Tom Seymour on 11/10/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import Foundation

class MuseumThing {
    let object: String
    let dateMade: String
    let placeMade: String
    let location: String
    let title: String
    let objectNumber: String
    let fullImageString: String
    let thumbImageString: String
    
    init(object: String, dateMade: String, placeMade: String, location: String, title: String, objectNumber: String, fullImageString: String, thumbImageString: String ) {
        self.object = object
        self.dateMade = dateMade
        self.placeMade = placeMade
        self.location = location
        self.title = title
        self.objectNumber = objectNumber
        self.fullImageString = fullImageString
        self.thumbImageString = thumbImageString
    }
    
    convenience init?(withDict dict: [String: Any]) {
        
        if let thisObject = dict["object"] as? String,
            let thisDateMade = dict["date_text"] as? String,
            let thisPlaceMade = dict["place"] as? String,
            let thisLocation = dict["location"] as? String,
            let title = dict["title"] as? String,
            let thisObjectNumber = dict["object_number"] as? String,
            let imageID = dict["primary_image_id"] as? String {
            
            let thisFullImageString = getFullImageString(imageID: imageID)
            let thisThumbImageString = getThumbImageString(imageID: imageID)
            
            let thisTitle = title.isEmpty ? "No Available Tile for this Object" : title
            
            self.init(object: thisObject, dateMade: thisDateMade, placeMade: thisPlaceMade, location: thisLocation, title: thisTitle, objectNumber: thisObjectNumber, fullImageString: thisFullImageString, thumbImageString: thisThumbImageString)
            
        } else {
            return nil
        }
    }
    
    static func buildMuseumThingArray(from data: Data) -> [MuseumThing]? {
        do {
            let museumJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let theWholeMuseumDict = museumJSONData as? [String: Any] else { return nil }
            guard let recordsArray = theWholeMuseumDict["records"] as? [[String: Any]] else {return nil}
            print(">>>>>>>>>>>>>> GOT RECORDS ARRAY")
            
            var museumThingArr = [MuseumThing]()
            
            for recordsDict in recordsArray {
                guard let fieldsDict = recordsDict["fields"] as? [String: Any] else { return nil }
                
                if let thisMuseumThing = MuseumThing(withDict: fieldsDict) {
                    museumThingArr.append(thisMuseumThing)
                }
            }
            
            return museumThingArr
            
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        return nil
    }
    
}

private func getFullImageString(imageID: String) -> String {
    var fullImageString = "http://media.vam.ac.uk/media/thira/collection_images/"
    fullImageString += String(imageID.characters.dropLast(4))
    fullImageString += "/"
    fullImageString += imageID
    fullImageString += ".jpg"
    return fullImageString
}

private func getThumbImageString(imageID: String) -> String {
    var thumbImageString = "http://media.vam.ac.uk/media/thira/collection_images/"
    thumbImageString += String(imageID.characters.dropLast(4))
    thumbImageString += "/"
    thumbImageString += imageID
    thumbImageString += "_jpg_o.jpg"
    return thumbImageString
}


