//
//  VictoriaObject.swift
//  VictoriaAlbert
//
//  Created by Margaret Ikeda on 11/10/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import Foundation


internal enum VictoriaObjectModelParseError: Error {
    case fieldsDictionary, name, dateText, place, title
}

internal struct VictoriaObject {
    let name: String
    let dateText: String
    let place: String
    let title: String?
//    let imageUrl: String
//    let thumbUrl: String
//    let primaryImageId: String
    
   
    
    static func victoriaObjects(from data: Data) -> [VictoriaObject]? {
        var victoriaObjectsToReturn:[VictoriaObject]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])

            guard let response = jsonData as? [String: Any],
                let arrayOfDictionaries = response["records"] as? [[String: Any]]
                else {
                    throw VictoriaObjectModelParseError.fieldsDictionary
            }
            print("@@@@Got fieldsDictionary@@@@")
            
            for victoriaObjectResults in arrayOfDictionaries {
                guard let fieldsDictionary = victoriaObjectResults["fields"] as? [String: Any] else {throw VictoriaObjectModelParseError.fieldsDictionary}
                
                
                guard let name = fieldsDictionary["object"] as? String
                else {
                        throw VictoriaObjectModelParseError.name
                }
                guard let dateText = fieldsDictionary["date_text"] as? String
                    else {
                        throw VictoriaObjectModelParseError.dateText
                }
                guard let place = fieldsDictionary["place"] as? String
                    else {
                        throw VictoriaObjectModelParseError.place
                }
                guard let title = fieldsDictionary["title"] as? String
                    else {
                        throw VictoriaObjectModelParseError.title
                }
                
                let validVictoriaObject = VictoriaObject(name: name, dateText: dateText, place: place, title: title) //imageUrl: imageUrl, thumbUrl: thumbUrl, primaryImageId: primaryImageId )
                
                victoriaObjectsToReturn?.append(validVictoriaObject)
            
            }
            print("Returning \(victoriaObjectsToReturn?.count) objects")
            return victoriaObjectsToReturn
        
        }
            
        catch {
            print("Error encountered with JSONSerialization: \(error)")
        }
        
        return nil
    }
    
}
