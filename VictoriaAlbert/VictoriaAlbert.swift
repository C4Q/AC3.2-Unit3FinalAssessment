//
//  VictoriaAlbert.swift
//  VictoriaAlbert
//
//  Created by Annie Tung on 11/10/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

struct VictoriaAlbert {
    let object: String
    let place: String
    let title: String
    let imageID: String
    
    let thumbnailImageURLString: String
    let fullImageURLString: String
    
    static func parseData(data: Data) -> [VictoriaAlbert]? {
        
        var victoriaAlbertToReturn: [VictoriaAlbert] = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let jsonDataCasted = jsonData as? [String:Any] else {
                print("Error parsing first layer of jsonData")
                return nil
            }
            guard let records = jsonDataCasted["records"] as? [[String:Any]] else {
                print("Error parsing second layer at records")
                return nil
            }

            for index in records {
                guard let fields = index["fields"] as? [String:Any] else {
                    print("Error parsing third layer at Fields")
                    return nil
                }
                guard let object = fields["object"] as? String else {
                    print("Error parsing object in fields")
                    return nil
                }
                guard let place = fields["place"] as? String else {
                    print("Error parsing place in fields")
                    return nil
                }
                guard let title = fields["title"] as? String else {
                    print("Error parsing title in fields")
                    return nil
                }
                guard let imageID = fields["primary_image_id"] as? String else {
                    print("Error parsing imageID in fields")
                    return nil
                }
                
                let imagePath = String(imageID.characters.prefix(6))
                
                let thumbnailImageUrlString = "http://media.vam.ac.uk/media/thira/collection_images/\(imagePath)/\(imageID)_jpg_o.jpg"
                
                let fullImageURLString = "http://media.vam.ac.uk/media/thira/collection_images/\(imagePath)/\(imageID).jpg"
                
                let vaObject = VictoriaAlbert(object: object, place: place, title: title, imageID: imageID, thumbnailImageURLString: thumbnailImageUrlString, fullImageURLString: fullImageURLString)
                
                victoriaAlbertToReturn.append(vaObject)
                dump(victoriaAlbertToReturn)
            }

        } catch {
            print("Error found while parsing at \(error)")
        }
        return victoriaAlbertToReturn
    }
}
