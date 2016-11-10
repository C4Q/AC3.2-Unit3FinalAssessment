//
//  VictoriaAlbert.swift
//  VictoriaAlbert
//
//  Created by Edward Anchundia on 11/10/16.
//  Copyright © 2016 Edward Anchundia. All rights reserved.
//

import Foundation

class VictoriaAlbert {
    let object: String
    let dateText: String
    let place: String
    let title: String
    let imageID: String
    
    init(object: String, dateText: String, place: String, title: String, imageID: String) {
        self.object = object
        self.dateText = dateText
        self.place = place
        self.title = title
        self.imageID = imageID
    }
    
    static func getVictoriaAlbert(from data: Data) -> [VictoriaAlbert]? {
        var dataToReturn: [VictoriaAlbert]? = []
        
        do {
            
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let fullDict: [String: Any] = jsonData as? [String: Any],
                let recordArrDict = fullDict["records"] as? [[String: Any]] else {
                    return nil
            }
            
            recordArrDict.forEach({ dataObject in
                guard let fieldsDict = dataObject["fields"] as? [String: Any],
                    let object = fieldsDict["object"] as? String,
                    let dateText = fieldsDict["date_text"] as? String,
                    let place = fieldsDict["place"] as? String,
                    let title = fieldsDict["title"] as? String,
                    let imageID = fieldsDict["primary_image_id"] as? String else {
                        return
                }
                
                let detail = VictoriaAlbert(object: object, dateText: dateText, place: place, title: title, imageID: imageID)
                dataToReturn?.append(detail)
                
            })
            
            return dataToReturn
            
        } catch {
            print("Unknown parsing error")
        }
        
        return nil
    }
}
