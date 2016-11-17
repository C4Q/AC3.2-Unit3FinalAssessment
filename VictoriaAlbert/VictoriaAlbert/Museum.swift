//
//  Museum.swift
//  VictoriaAlbert
//
//  Created by Ilmira Estil on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal enum JsonSerialization: Error {
    case museumJson(jsonData: Any)
    case recordsDict(museumJson: [String:Any])
}

internal enum Parsing: Error {
    case fields(recordsDict: [[String : AnyObject]])
    case object(fields: [String : AnyObject])
    case date(fields: [String : AnyObject])
    case imageId(fields: [String : AnyObject])
    case place(fields: [String : AnyObject])
}


//http://media.vam.ac.uk/media/thira/collection_images/2006AM/2006AM6763_jpg_o.jpg
//http://media.vam.ac.uk/media/thira/collection_images/2006AM/2006AM6763.jpg

class Museum {
    let object: String
    let date: String
    let place: String
    let imageId: String
    let imageIdShort: String
    
    
    init(object: String, date: String, place: String, imageId: String, imageIdShort: String) {
        self.object = object
        self.date = date
        self.place = place
        self.imageId = imageId
        self.imageIdShort = imageIdShort
        
    }
    
    static func buildMuseum(from data: Data) -> [Museum]? {
        var arrOfMuseumFields = [Museum]()
        do {
            let jsonData = try? JSONSerialization.jsonObject(with: data, options: [])
            
            guard let museumJson = jsonData as? [String:AnyObject] else {
                throw JsonSerialization.museumJson(jsonData: jsonData)
            }
            guard let recordsDict = museumJson["records"] as? [[String:AnyObject]] else {
                throw JsonSerialization.recordsDict(museumJson: museumJson)
            }
            
            for dict in recordsDict {
                guard let fieldDict = dict["fields"] as? [String:AnyObject] else {throw Parsing.fields(recordsDict: recordsDict)}
                guard let object = fieldDict["object"] as? String else
                {throw Parsing.object(fields: fieldDict)}
                guard let date = fieldDict["date_text"] as? String else
                {throw Parsing.date(fields: fieldDict)}
                guard let place = fieldDict["place"] as? String else
                {throw Parsing.place(fields: fieldDict)}
                guard let imageId = fieldDict["primary_image_id"] as? String
                    else {throw Parsing.imageId(fields: fieldDict)}
                
                //image id //Str code from apple doc
                let rangeForSubstring = imageId.index(imageId.endIndex, offsetBy: -4)..<imageId.endIndex
                var imageIdShort = imageId
                imageIdShort.removeSubrange(rangeForSubstring)
                
                let museumProperty = Museum.init(object: object, date: date, place: place, imageId: imageId, imageIdShort: imageIdShort)
                arrOfMuseumFields.append(museumProperty)
            }
        } catch let JsonSerialization.museumJson(jsonData: jsonData) {
            print("Error jsonData: \(jsonData)")
        } catch let JsonSerialization.recordsDict(museumJson: museumJson) {
            print("Error museumJson: \(museumJson)")
        } catch let Parsing.fields(recordsDict: recordsDict) {
            print("Error recordsDict: \(recordsDict)")
        } catch let Parsing.object(fields: fieldDict) {
            print("Error fieldDict Object: \(fieldDict)")
        }  catch let Parsing.date(fields: fieldDict) {
            print("Error fieldDict Date: \(fieldDict)")
        }  catch let Parsing.place(fields: fieldDict) {
            print("Error fieldDict Place: \(fieldDict)")
        }  catch let Parsing.imageId(fields: fieldDict) {
            print("Error fieldDict ImageId: \(fieldDict)")
        }   catch {
            print(error)
        }
        
        return arrOfMuseumFields
    }
}
