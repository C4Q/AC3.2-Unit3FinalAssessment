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
    let pic: String
    
    init(title: String, subtitle: String, pic: String) {
        self.title = title
        self.subtitle = subtitle
        self.pic = pic
    }
    
    static func makeBricArr(from data: Data) -> [BricABrac]? {
        var bricArr: [BricABrac] = []
        
        do {
            let theBigBox = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let castTheBox = theBigBox as? [String:Any] else {
                print("There was an error casting from [String:Any] to Any \(theBigBox)")
                return nil
            }
    //        print("We made \(theBigBox)")
            
            guard let records = castTheBox["records"] as? [[String : Any]] else {
                print("There was an error casting from [String:Any] to [String:Any] so we couldn't get records \(castTheBox)")
                return nil
            }
            
            for item in records {
            
                guard let fields = records[0] as? [String: Any] else {
                    print("There was an error casting from [[String: Any]] to [String:Any] so we couldn't get fields \(records)")
                    return nil
                }
                // subtitles are easy
                //oh i need to get into the fields...which are an array of dictionaries...
                    guard let itemsSubTitle = fields["title"] as? String else {return nil}
                    // titles are complicated
                    guard let firstPartOfTitle = fields["object"] as? String else {return nil}
                    guard let secondPartOfTitle = fields["date-text"] as? String else {return nil}
                    guard let thirdPartOfTitle = fields["place"] as? String else {return nil}
                
                    let itemsTitle = firstPartOfTitle + secondPartOfTitle + thirdPartOfTitle
                    print(itemsTitle)
                // so are pics
                guard let imgIDString = fields["primary_image_id"] as? String else {return nil}
                let itemsPic = imgIDString
                print(itemsPic)
                
                let individalBricABrac = BricABrac(title: itemsTitle, subtitle: itemsSubTitle, pic: itemsPic)
                
                bricArr.append(individalBricABrac)
            }
            
            print(bricArr)
            
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
