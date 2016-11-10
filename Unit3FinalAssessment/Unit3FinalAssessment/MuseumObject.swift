//
//  MuseumObject.swift
//  Unit3FinalAssessment
//
//  Created by C4Q on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation



class MuseumObject {
    
    let title: String
    let image: String
    let thumbImage: String
    let description: String
    let subtitle: String
    
    init (title: String, image: String, thumbImage: String, description: String, subtitle: String) {
        self.description = description
        self.image = image
        self.subtitle = subtitle
        self.thumbImage = thumbImage
        self.title = title
    }
    
    
    /*
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
     */
    
    convenience init? (record: [String: Any]) {
        guard let dict = record["fields"] as? [String: AnyObject] else {
            print("dict failed")
            return nil
        }
        
        guard let subtitle = dict["title"] as? String else  {
            print("subtitle failed")
            return nil
        }
        
        guard let imageIDPrimary = dict["primary_image_id"] as? String else  {
            print("imageID failed")
            return nil
        }
        
        guard let object = dict["object"] as? String else  {
            print("object failed")
            return nil
        }
        
        guard let date = dict["date_text"] as? String else  {
            print("date failed")
            return nil
        }
        
        guard let place = dict["place"] as? String else  {
            print("place failed")
            return nil
        }
        
        guard let objectNumber = dict["object_number"] as? String else {
            print("objectNumber failed")
            return nil
        }
        
        let description = "http://www.vam.ac.uk/api/json/museumobject/\(objectNumber)"
        let title = "\(object) from: \(date) located: \(place)"
        var image = ""
        var thumbImage = ""
        
        if imageIDPrimary.characters.count > 6 {
            let imageIDRange = imageIDPrimary.index(imageIDPrimary.startIndex, offsetBy: 6)..<imageIDPrimary.endIndex
            let imageID = imageIDPrimary.replacingCharacters(in: imageIDRange, with: "")
            image = "http://media.vam.ac.uk/media/thira/collection_images/\(imageID)/\(imageIDPrimary).jpg"
            thumbImage = "http://media.vam.ac.uk/media/thira/collection_images/\(imageID)/\(imageIDPrimary)_jpg_o.jpg"
        }
        
        self.init(title: title, image: image, thumbImage: thumbImage, description: description, subtitle: subtitle)
        
        
    }
    
    static func parseData (data: Data) -> [MuseumObject]? {
        var objects = [MuseumObject]()
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let dict = jsonObject as? [String: AnyObject] else  {
                print("dict failed")
                return nil
            }
            guard let records = dict["records"] as? [[String:AnyObject]] else  {
                print("records failed")
                return nil
            }
            
            for record in records {
                guard let object = MuseumObject(record: record) else  {
                    print("object failed")
                    return nil
                }
                
                objects.append(object)
            }
            
            
        }
        catch {
            print(error)
        }
        return objects
    }
}
