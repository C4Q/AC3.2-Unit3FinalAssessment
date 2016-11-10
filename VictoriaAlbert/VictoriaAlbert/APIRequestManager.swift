//
//  APIRequestManager.swift
//  VictoriaAlbert
//
//  Created by Tong Lin on 11/10/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import Foundation

internal class APIRequestManager {
    internal static let manager: APIRequestManager = APIRequestManager()
    init() {}
    
    func getObjects(keyWords: String, callback: @escaping ((Data?)->Void)){
        let url: URL = URL(string: "http://www.vam.ac.uk/api/json/museumobject/search?q=\(keyWords)")!
        
        let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: url){ (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil{
                print(error!)
            }
            
            if data != nil{
                print("We have valid data here")
                callback(data)
            }
        }.resume()
    }
    
    func downloadImage(imageID: String, switchPic: Int, callback: @escaping ((Data?)->Void)){
        var key = imageID
        while key.characters.count != 6 {
            key.remove(at: key.index(before: key.endIndex))
        }
        print(imageID, key)
        
        let url: URL
        switch switchPic {
        case 0:
            url = URL(string: "http://media.vam.ac.uk/media/thira/collection_images/\(key)/\(imageID)_jpg_o.jpg")!
        case 1:
            url = URL(string: "http://media.vam.ac.uk/media/thira/collection_images/\(key)/\(imageID).jpg")!
        default:
            url = URL(string: "")!
        }
        
        let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: url){ (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil{
                print(error!)
            }
            
            if data != nil{
                print("We have valid image here")
                callback(data)
            }
        }.resume()
    }
    
}
