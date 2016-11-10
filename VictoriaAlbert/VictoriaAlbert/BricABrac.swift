//
//  BricABrac.swift
//  VictoriaAlbert
//
//  Created by Marty Avedon on 11/10/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import Foundation

class BricABrac {
    let title: String // Cell titles should be constructed from {object}, {date_text} - {place}, for example
    let subtitle: String // From title field
    let pic: Pic
    
    init(title: String, subtitle: String, pic: Pic) {
        self.title = title
        self.subtitle = subtitle
        self.pic = pic
    }
    
    static func makeBricArr(from data: Data) -> [BricABrac]? {
        var bricArr: [BricABrac] = []
        
        do {
            let theBigBox:Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let castTheBox: [String:Any] = theBigBox as? [String:Any] else {
                print("there was an error casting to [String:Any] \(theBigBox)")
                return nil
            }
            print("We made \(theBigBox)")
            
            guard let records: [String: Any?] = castTheBox["records"] as? [String : Any?] else {
                print("There was an error casting from [String:Any] to Any \(castTheBox)")
                return nil
            }
            
            for item in records {
                // subtitles are easy
                guard let itemsSubTitle = records["title"] else {return nil}
                // titles are complicated
                guard let firstPartOfTitle = records["object"] as? String else {return nil}
                guard let secondPartOfTitle = records["date-text"] as? String else {return nil}
                guard let thirdPartOfTitle = records["place"] as? String else {return nil}
                
                let itemsTitle = firstPartOfTitle + secondPartOfTitle + thirdPartOfTitle
                // so are pics
                guard let imgIDString = records["primary_image_id"] as? String else {return nil}
                let itemsPic = Pic(imgIDString)
                
                let individalBricABrac = BricABrac(title: itemsTitle, subtitle: itemsSubTitle, itemsPic: Pic)
                
                bricArr.append(individalBricABrac)
            }
            
        } catch {
        
        }
        
        return nil
    }
    
//    static func makeBricArray(from data: Data) -> [BricABrac]? {
//        var bricArr: [BricABrac] = []
//        
//        do {// dictionary level 1
//            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: [])
//            
//            guard let jsonCasted: [String:Any] = jsonData as? [String:Any] else {
//                print("there was an error casting to [String:Any] \(jsonData)")
//                return nil
//            }
//            print("Object created: \(jsonCasted)")
//            
//            // dictionary level 2
//            guard let records: [[String:Any?]] = jsonCasted["records"] as! [[String : Any]] else {
//                print("There was an error casting from [String:Any] to Any \(jsonCasted)")
//                return nil
//            }
//            print("Info was cast: \(records)")
//            
            // obtaining the entries
//            var objects = [BricABrac]()
//            records.forEach({ object in
//                if let title: String = object["name"] as? String,
//                    let subtitle: String = object["title"]? as String
//                    let pic: String = object["primary_image_id"]? as! String,
//                    // Some of these values need further casting
//                    let instaDogID: Int = Int(instaDogIDString),
//                    let instaDogFollowers: Int = Int(instaDogFollowersString),
//                    let instaDogFollowing: Int = Int(instaDogFollowingString),
//                    let instaDogPosts: Int = Int(instaDogPostsString),
//                    let instaDogInstagramURL: URL = URL(string: instaDogInstagramURLString){
//                    
//                    // append to our temp array
//                        objects.append(BricABrac(title: title, subtitle: subtitle, pic: pic))
//                    
//                }
//            
//        return bricArr
//        }
//            catch let error as NSError {
//                print("Error occurred while parsing data: \(error.localizedDescription)")
//            }
//            
//            return  nil
//        }
//    }
}
