//
//  APIRequestManager.swift
//  VictoriaAlbert
//
//  Created by John Gabriel Breshears on 11/10/16.
//  Copyright © 2016 John Gabriel Breshears. All rights reserved.
//

import Foundation

class APIRequestManager {
    
    static let manager = APIRequestManager()
    private init() {}
    
    func getData(searchKey: String, callback: @escaping (Data?) -> Void) {
      
        // Mabye instead of banging this, unwrap safely
        let myURL = URL(string: "http://www.vam.ac.uk/api/json/museumobject/search?q=\(searchKey)")!
        
        
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error durring session: \(error)")
            }
            guard let validData = data else { return }
            callback(validData)
            }.resume()
    }
    //Okay for this to work I need to somehow get only the first 6 digits of the primary id or small id
    func getLittlePicture(primaryImageId: String, smallId: String, callback: @escaping (Data?) -> Void) {
        
        
        let myURL: URL = URL(string: "http://media.vam.ac.uk/media/thira/collection_images/\(smallId)/\(primaryImageId)_jpg_o.jpg")!
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error during session: \(error)")
            }
            guard let validData = data else { return }
            callback(validData)
            }.resume()
        
        
    }

    
    
    
    
    
}




