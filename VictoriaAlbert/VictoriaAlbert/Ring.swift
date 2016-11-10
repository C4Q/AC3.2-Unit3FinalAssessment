//
//  Ring.swift
//  VictoriaAlbert
//
//  Created by Thinley Dorjee on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class Ring{
    
    let object: String
    let place : String
    let date: String
    let id: String
    
    init(object: String, place: String, date: String, id: String){
        self.object = object
        self.place = place
        self.date = date
        self.id = id
    }

    
    static func getJsonData(from data: Data) -> [Ring]?{
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let response = jsonData as? [String: Any] else {return nil}
            guard let records = response["records"] as? [[String: Any]] else {return nil}
            print("2222222222\(records)")
            
            var ringToReturn = [Ring]()
            
            for objts in  records{
            guard let fields = objts["fields"] as? [String: Any] else {return nil}
                guard let objectName = fields["object"] as? String else {return nil}
                print("!!!!!!!!!!!!!!\(objectName)")
                guard let objectPlace = fields["place"] as? String else {return nil}
                print("!!!!!!!!!!!!!!\(objectPlace)")
                guard let objectDate = fields["date_text"] as? String else {return nil}
                print("!!!!!!!!!!!!!!\(objectDate)")
                guard let id = fields["primary_image_id"] as? String else {return nil}
                
                
                let allObject = Ring(object: objectName, place: objectPlace, date: objectDate, id: id)
                ringToReturn.append(allObject)
            }
            return ringToReturn
        }
        catch let error as NSError{
            print("Error Encountered: \(error)")
        }
        return nil
    }

}
