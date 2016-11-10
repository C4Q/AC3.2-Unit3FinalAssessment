//
//  Description.swift
//  Unit3FinalAssessment
//
//  Created by C4Q on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation


class Description {
    
    let decription: String
    
    init (description: String) {
        self.decription = description
    }
    
    static func getDescription (data: Data) -> Description? {
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let arr = jsonData as? [[String: AnyObject]] else {
                print("description dict failed")
                return nil
            }
            let dictOne = arr[0]
            
            guard let dict = dictOne["fields"] as? [String: AnyObject] else {return nil}
            
            guard let historicalDescript = dict["history_note"] as? String else {
                print("description history failed")
                return nil
            }
            guard let publicAccessDescription = dict["public_access_description"] as? String else {
                print("description PA failed")
                return nil
            }
            
            guard let descriptiveLine = dict["descriptive_line"] as? String else {
                print("description descriptiveLine failed")
                return nil
            }
            
            let descriptionWithTags = "\(descriptiveLine) \n Description: \(publicAccessDescription) \n Historical Significance: \(historicalDescript)"
            
            let description = descriptionWithTags.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            
            return Description(description: description)
        }
        catch {
            print("Error: \(error)")
        }
        return nil
    }
    
    
}
