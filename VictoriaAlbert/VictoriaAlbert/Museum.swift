//
//  Museum.swift
//  VictoriaAlbert
//
//  Created by John Gabriel Breshears on 11/10/16.
//  Copyright © 2016 John Gabriel Breshears. All rights reserved.
//

import Foundation

class Museum {
    let items: [Item]
 //   let fields: [Field]


init(items: [Item]) {
    self.items = items
}

    
    static func getMuseumData(from data: Data) -> [Item]? {
        var recordsArray: [Item] = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let dictionary:[String:Any] = jsonData as? [String:Any] else {
                return nil
            }
            guard let records = dictionary["records"] as? [[String:Any]] else {
                return nil
            }
            // So currently records has three elements in it. It has pk, fields, and model. I want what is inside fields. SO i need to itreate over records. then r will be a dictionary.
            for r in records {
               //Okay now fields has all of the key and values that reside in the dictionary. SO what do i do next? I created a convience init to cut up the data so How do i feed the results of fields into it?
                guard let fields = r["fields"] as? [String:Any] else {
                    return nil
                }
                if let fieldsObject = Item.init(from: fields) {
                    recordsArray.append(fieldsObject)
                    // Now my recordsArray(What a shitty name) has object(Gimmel rign),date_text(ca.1600(made),place(Germany),title,primary_image_id(2006AM3589),location(Britsh Galleries). And those objects are filled with the values. NOw what should i do with an array of objects that i need to display?
                    
                }
                
                }
            }
            
    
        catch {
            print("IDK")
}
return recordsArray


}


    
}


//Below are a few of my ideas on how to model the data
//
//convenience init?(from dictionary: [String:AnyObject]) throws {
//    if let name = dictionary["name"] as? String,
//        let images = dictionary["images"] as? [[String:AnyObject]] {
//        var imageArr = [Image]()
//        for im in images {
//            if let imageObj = Image(from: im) {
//                imageArr.append(imageObj)
//            }
//            else {
//                throw AlbumModelParseError.image(image: im)
//            }
//        }
//        self.init(name: name, images: imageArr)
//    }
//    else {
//        return nil
//    }
//}

/*
class Museum {
 
        let object: String
        let date_text: String
        let place: String
        let title: String
        let primary_image_id: String
    

    init(object: String, date_text: String, place: String, title: String, primary_image_id: String) {
        self.object = object
        self.date_text = date_text
        self.place = place
        self.title = title
        self.primary_image_id = primary_image_id
        
        
}
    static func getMuseumData(from data: Data) -> Museum? {
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let dictionary:[String:Any] = jsonData as? [String:Any] else {
                return nil
            }
            guard let records = dictionary["records"] as? [Any],
            let recordsArray = records[0] as? [String:Any],
                let object: String = recordsArray["object"] as? String,
                let date_text: String = recordsArray["date_text"] as? String,
            let place: String = recordsArray["place"] as? String,
                let title: String = recordsArray["tilte"] as? String,
                let primary_image_id: String = recordsArray["primary_image_id"] as? String else {
                    return nil
            }
            return Museum(object: object, date_text: date_text, place: place, title: title, primary_image_id: primary_image_id)
        }
        catch {
            print("error of somesort")
        }
        return nil 
    }
    
    
}
*/
