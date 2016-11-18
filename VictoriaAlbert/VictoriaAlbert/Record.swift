//
//  Record.swift
//  VictoriaAlbert
//
//  Created by Victor Zhong on 11/10/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import Foundation

enum RecordModelParseError: Error {
    case results, fields, object, image, date, place, title
}

class Record {
    let object:		String
    let imageBig:	String //primary_image_id\
    let imageSmall:	String
    let date:		String //date_text
    let place:		String //place
    let title:		String //title
    
    init(object:	String,
         imageBig:	String,
         imageSmall:String,
         date:		String,
         place:		String,
         title:		String
        )
    {
        self.object = object
        self.imageBig = imageBig
        self.imageSmall = imageSmall
        self.date = date
        self.place = place
        self.title = title
    }
    
    convenience init?(from dictionary: [String:AnyObject]) throws {
        guard let fields = dictionary["fields"] as? [String : AnyObject] else { throw
            RecordModelParseError.fields }
        guard let object = fields["object"] as? String else { throw RecordModelParseError.object }
        guard let image = fields["primary_image_id"] as? String else { throw RecordModelParseError.image }
        guard image != "" else { return nil }
        guard let date = fields["date_text"] as? String else { throw RecordModelParseError.date }
        guard let place = fields["place"] as? String else { throw RecordModelParseError.place }
        guard let title = fields["title"] as? String else { throw RecordModelParseError.title }
        
        func imageToUrl(input: String, big: Bool) -> String {
            guard input.characters.count > 0 else { return "" }
            var baseURL = "http://media.vam.ac.uk/media/thira/collection_images/"
            
            if image.characters.count > 6 {
                let index = input.index(image.startIndex, offsetBy: 6)
                baseURL += input.substring(to: index)
            } else {
                baseURL += input
            }
            
            if big {
                baseURL += "/\(input).jpg"
            } else {
                baseURL += "/\(input)_jpg_o.jpg"
            }
            return baseURL
        }
        
        self.init(object: object,
                  imageBig: imageToUrl(input: image, big: true),
                  imageSmall: imageToUrl(input: image, big: false),
                  date: date,
                  place: place,
                  title: title)
    }
    
    static func getRecords(from data: Data) -> [Record]? {
        var recordsToReturn: [Record]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [String : AnyObject] = jsonData as? [String : AnyObject],
                let records = response["records"] as? [[String: AnyObject]] else {
                    throw RecordModelParseError.results
            }
            
            for recordDict in records {
                if let record = try Record(from: recordDict) {
                    recordsToReturn?.append(record)
                }
            }
        }
        catch {
            print("Parsing Error: \(error)")
        }
        return recordsToReturn
    }
}


//records: [
//{
//pk: 9431,
//model: "collection.museumobject",
//fields: {
//primary_image_id: "2006AM6786",
//rights: 3,
//year_start: 1540,
//object_number: "O78598",
//artist: "Unknown",
//museum_number: "M.5-1960",
//object: "Seal ring",
//longitude: "-0.12714000",
//last_processed: "2016-10-28 19:07:00",
//event_text: "",
//place: "London",
//location: "British Galleries, room 58e, case 5",
//last_checked: "2016-10-28 19:07:00",
//museum_number_token: "m51960",
//latitude: "51.50632100",
//title: "",
//date_text: "ca. 1545 (made)",
//slug: "seal-ring-unknown",
//sys_updated: "2015-02-18 00:00:00",
//collection_code: "MET"
//}
//}
