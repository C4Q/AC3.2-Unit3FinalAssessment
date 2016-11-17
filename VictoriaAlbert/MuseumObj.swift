//
//  MuseumObj.swift
//  VictoriaAlbert
//
//  Created by Kadell on 11/10/16.
//  Copyright © 2016 Kadell. All rights reserved.
//

import Foundation


enum ErrorThrows: Error {
    case fields, object, place, date, image, title

}

struct MuseumObj {
    
    let object: String
    let place: String
    let date: String
    let imageID: String
    let title: String
    
    static func getMuseumObj(from data: Data) -> [MuseumObj]? {
        do{
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let museumDict = jsonData as? [String: Any] else {
                print("There was an error casting from jsonData: \(jsonData)")
                return nil
            }
            
            guard let getRecords = museumDict["records"] as? [[String: Any]] else {
                print("***********IM GOOD TILL HERE ***************")
                return nil
            }
            
            var allObjects: [MuseumObj] = []

            for dict in getRecords {
                guard let fields = dict["fields"] as? [String: Any] else {
                    throw ErrorThrows.fields }
                
                guard let objectName = fields["object"] as? String else {
                    throw ErrorThrows.object
                }
                guard let dateOf = fields["date_text"] as? String else {
                    throw ErrorThrows.date
                }
                
                guard let placeOf = fields["place"] as? String else {
                    throw ErrorThrows.place
                }
                
                guard let image = fields["primary_image_id"] as? String else {
                    throw ErrorThrows.image
                }
                
                guard let title = fields["title"] as? String else {
                    throw ErrorThrows.title
                }
                
                let museum = MuseumObj(object: objectName, place: placeOf, date: dateOf, imageID: image, title: title)
                allObjects.append(museum)
            }
          return allObjects
            
            
        }
        catch ErrorThrows.date {
        print("Their was an error finding the items date.")
        }
        catch ErrorThrows.fields {
            print("Their was an error finding the field.")
            
        } catch ErrorThrows.object {
            print("Their was an error finding the items object.")
        }
        catch ErrorThrows.place {
            print("Their was an error finding the items place.")
        }
        catch ErrorThrows.image {
            print("Their was a problmem finding photoID")
        }
        catch ErrorThrows.title {
            print("Their was a problem finding the title")
        }
        catch {print("Dont know whats Missing ")}
        
    return nil
    }

}
