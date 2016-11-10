//
//  Records.swift
//  VictoriaAlbert
//
//  Created by Cris on 11/10/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import Foundation

enum RecordsModelParseError: Error {
    case records
}

class Records {
    let object: String
    let date_text: String
    let place: String
    let image: String
    let location: String
    var smallImageURL: String {
        return "http://media.vam.ac.uk/media/thira/collection_images/2006AM/\(image)_jpg_o.jpg"

    }
    
    var largeImageURL: String {
        return "http://media.vam.ac.uk/media/thira/collection_images/2006AM/\(image).jpg"

    }
    
    init(object: String, date_text: String, place: String, image: String, location: String) {
        self.object = object
        self.date_text = date_text
        self.place = place
        self.image = image
        self.location = location
    }
    
    convenience init?(from recordDict: [String : Any]) {
        guard let fields = recordDict["fields"] as? [String : Any] else {return nil}
        guard let objectName = fields["object"] as? String,
            let dateText = fields["date_text"] as? String,
            let objectPlace = fields["place"] as? String,
            let imageString = fields["primary_image_id"] as? String,
            let objectLocation = fields["location"] as? String else {return nil}
        
        self.init(object: objectName, date_text: dateText, place: objectPlace, image: imageString, location: objectLocation)
        
    }
    
    
    static func object(from data: Data) -> [Records]? {
        var recordsToReturn: [Records]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [String : Any] = jsonData as? [String : Any],
                let recordDict = response["records"] as? [[String : Any]]
                else {throw RecordsModelParseError.records}
          
            recordDict.forEach({ (recordObject) in
                if let record = Records(from: recordObject) {
                    recordsToReturn?.append(record)
                }
            })
            
        }
        catch RecordsModelParseError.records {
            print("ERORR ENCOUNTERED WITH PARSING 'RECORDS' FOR OBJECT")
        }
        catch {
            print("UNKNOWN PARSING ERORR")
        }
        
        return recordsToReturn
    }
}
