//
//  SecondaryMuseum.swift
//  VictoriaAlbert
//
//  Created by Ilmira Estil on 11/12/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal enum jsonSerialization: Error {
    case response(jsonData: Any)
    case records(response: [String : AnyObject])
}

internal enum recordsParsing: Error {
    case fields(records: [[String : AnyObject]])
    case primaryImageId(fields: [String : AnyObject])
    case objectNumber(fields: [String : AnyObject])
    case artist(fields: [String : AnyObject])
    case object(fields: [String : AnyObject])
    case place(fields: [String : AnyObject])
    case location(fields: [String : AnyObject])
    case title(fields: [String : AnyObject])
    case dateText(fields: [String : AnyObject])
    case slug(fields: [String : AnyObject])
    case collectionCode(fields: [String : AnyObject])
}

class MuseumObject {
    let primaryImageId: String
    let objectNumber: String
    let artist: String
    let object: String
    let place: String
    let location: String
    let title: String
    let dateText: String
    let slug: String
    let collectionCode: String
    let smallImage: String
    let largeImage: String
    
    init(primaryImageId : String, objectNumber: String, artist: String, object: String, place: String, location: String, title: String, dateText: String, slug: String, collectionCode: String) {
        self.primaryImageId = primaryImageId
        self.objectNumber = objectNumber
        self.artist = artist
        self.object = object
        self.place = place
        self.location = location
        self.title = title
        self.dateText = dateText
        self.slug = slug
        self.collectionCode = collectionCode
        
        var firstSixChars = ""
        
        if primaryImageId.characters.count > 6 {
            let indexTo6 = primaryImageId.index(primaryImageId.startIndex, offsetBy: 6)
            firstSixChars = primaryImageId.substring(to: indexTo6)
        } else {
            firstSixChars = primaryImageId
        }
        
        self.largeImage = "http://media.vam.ac.uk/media/thira/collection_images/\(firstSixChars)/\(primaryImageId).jpg"
        self.smallImage = "http://media.vam.ac.uk/media/thira/collection_images/\(firstSixChars)/\(primaryImageId)_jpg_o.jpg"
    }
    
    static func getDataFromJson(data: Data) -> [MuseumObject]? {
        var museumObject = [MuseumObject]()
        
        do {
            let jsonData = try? JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response = jsonData as? [String: AnyObject] else {
                throw jsonSerialization.response(jsonData: jsonData)
            }
            guard let records = response["records"] as? [[String: AnyObject]] else {
                throw jsonSerialization.records(response: response)
            }
            
            for record in records {
                guard let fields = record["fields"] as? [String: AnyObject] else {
                    throw recordsParsing.fields(records: records)
                }
                guard let primaryImageId = fields["primary_image_id"] as? String else {
                    throw recordsParsing.primaryImageId(fields: fields)
                }
                guard let objectNumber = fields["object_number"] as? String else {
                    throw recordsParsing.objectNumber(fields: fields)
                }
                guard let artist = fields["artist"] as? String else {
                    throw recordsParsing.artist(fields: fields)
                }
                guard let object = fields["object"] as? String else {
                    throw recordsParsing.object(fields: fields)
                }
                guard let place = fields["place"] as? String else {
                    throw recordsParsing.place(fields: fields)
                }
                guard let location = fields["location"] as? String else {
                    throw recordsParsing.location(fields: fields)
                }
                guard let title = fields["title"] as? String else {
                    throw recordsParsing.title(fields: fields)
                }
                guard let dateText = fields["date_text"] as? String else {
                    throw recordsParsing.dateText(fields: fields)
                }
                guard let slug = fields["slug"] as? String else {
                    throw recordsParsing.slug(fields: fields)
                }
                guard let collectionCode = fields["collection_code"] as? String else {
                    throw recordsParsing.collectionCode(fields: fields)
                }
                
                let mo = MuseumObject(primaryImageId: primaryImageId, objectNumber: objectNumber, artist: artist, object: object, place: place, location: location, title: title, dateText: dateText, slug: slug, collectionCode: collectionCode)
                museumObject.append(mo)
            }
        } catch let jsonSerialization.response(jsonData: jsonData) {
            print("PARSE ERROR: \(jsonData)")
        } catch let jsonSerialization.records(response: response) {
            print("PARSE ERROR: \(response)")
        } catch let recordsParsing.fields(records: records) {
            print("PARSE ERROR: \(records)")
        } catch let recordsParsing.primaryImageId(fields: fields) {
            print("PARSE ERROR: \(fields)")
        } catch let recordsParsing.objectNumber(fields: fields) {
            print("PARSE ERROR: \(fields)")
        } catch let recordsParsing.artist(fields: fields) {
            print("PARSE ERROR: \(fields)")
        } catch let recordsParsing.object(fields: fields) {
            print("PARSE ERROR: \(fields)")
        } catch let recordsParsing.place(fields: fields) {
            print("PARSE ERROR: \(fields)")
        } catch let recordsParsing.location(fields: fields) {
            print("PARSE ERROR: \(fields)")
        } catch let recordsParsing.title(fields: fields) {
            print("PARSE ERROR: \(fields)")
        } catch let recordsParsing.dateText(fields: fields) {
            print("PARSE ERROR: \(fields)")
        } catch let recordsParsing.slug(fields: fields) {
            print("PARSE ERROR: \(fields)")
        } catch let recordsParsing.collectionCode(fields: fields) {
            print("PARSE ERROR: \(fields)")
        } catch {
            print(error)
        }
        
        return museumObject
    }
}
