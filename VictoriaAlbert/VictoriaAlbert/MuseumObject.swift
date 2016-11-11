//
//  MuseumObject.swift
//  VictoriaAlbert
//
//  Created by Jermaine Kelly on 11/10/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation

class Record{
    
    let name: String
    let place: String
    let title: String
    let date: String
    let artist: String
    let location: String
    let imageID: String
    
    
    init (name:String, place:String, title:String, date:String,artist:String,location:String, imageID:String){
        self.name = name
        self.place = place
        self.title = title
        self.date = date
        self.artist = artist
        self.location = location
        self.imageID = imageID
    }
    
    
    
    convenience init? (from objectDict: [String:Any]){
        if let name = objectDict["object"] as? String,
            let place = objectDict["place"] as? String,
            let title = objectDict["title"] as? String,
            let date = objectDict["date_text"] as? String,
            let artist = objectDict["artist"] as? String,
            let location = objectDict["location"] as? String,
            let imageId = objectDict["primary_image_id"] as? String{
            
            self.init(name:name,place:place,title:title,date:date,artist:artist,location:location, imageID:imageId)
            
        }else{
            return nil
        }
  
    }
    
    
    //makes record objects from data
    static func makeObjects(from data:Data) -> [Record]?{
        var objectResults: [Record] = []
        do{
            let jSONCast = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let jSonData = jSONCast as? [String:Any],
                let recordsArray = jSonData["records"] as? [[String:Any]] else{ return nil}
            
            
            for record in recordsArray{
                if let fields = record["fields"] as? [String:Any]{
                    objectResults.append(Record(from: fields)!)
                }
            }
            
     
        }catch{
            print(error.localizedDescription)
        }
        
        return objectResults
    }
    
    
    
}
