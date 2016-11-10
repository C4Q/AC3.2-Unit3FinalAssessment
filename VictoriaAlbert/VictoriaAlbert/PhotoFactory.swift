//
//  PhotoFactory.swift
//  VictoriaAlbert
//
//  Created by Amber Spadafora on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class PhotoFactory {
    
    static let manager: PhotoFactory = PhotoFactory()
    private init() {}
    
    //MARK: Data Parsing
    
    internal func getPhotoData(from jsonData: Data) -> [Photo]? {
        
        do {
            let photoJsonData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            
            guard let photoJSONCasted: [String: Any] = photoJsonData as? [String: Any] else {
                    return nil
            }
            
            guard let photoDictionaryArray: [[String: Any]] = photoJSONCasted["records"] as? [[String: Any]] else {
                    return nil
                }
            
            var photoResults: [Photo] = []
            
            
            for dictionary in photoDictionaryArray {
                
                if let fieldsDictionary: [String: Any] = dictionary["fields"] as? [String: Any] {
                    if let photoObject = Photo(from: fieldsDictionary) {
                        photoResults.append(photoObject)
                    }
                } else {
                    print("error encountered while initializing an instance of Photo")
                }
            }
            return photoResults
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        return nil
    }
}
