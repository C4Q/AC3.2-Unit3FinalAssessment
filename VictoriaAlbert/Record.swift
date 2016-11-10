//
//  Record.swift
//  VictoriaAlbert
//
//  Created by Karen Fuentes on 11/10/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import Foundation



class Record {
     let object: String
     let date_Text: String
     let place: String
    let imageID: String
    
    init(object: String, date_Text: String, place: String, imageID: String) {
        self.object = object
        self.date_Text = date_Text
        self.place = place
        self.imageID = imageID
    }
    
    static func getRecords(from data: Data) -> [Record]? {
        var record: [Record]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response = jsonData as? [String: Any],
                let records = response["records"] as? [[String: Any]]
                else { return nil }
            
            for each in records {
                
                guard let fields = each["fields"] as? [String: Any]
                    else { return nil}
                
                guard let object = fields["object"] as? String
                    else { return nil }
                
                guard let dateText = fields["date_text"] as? String
                    else { return nil }
                
                guard let place = fields["place"] as? String
                    else {return nil }
                
                guard let imageID = fields["primary_image_id"] as? String
                    else { return nil }
                
                let r = Record(object: object,date_Text: dateText, place: place,imageID: imageID)
                
                record?.append(r)
            }
            return record
        }
        catch {
            print("error: \(error)")
        }
        
        return nil
    }
}
    
    
    
    
    
    
    
