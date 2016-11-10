//
//  APIManager.swift
//  Unit3FinalAssessment
//
//  Created by C4Q on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation


class APIManager {
    
    static let manager = APIManager()
    private init () {}
    
    func getData (endPoint: String, callback: @escaping (Data?) -> Void) {
        
        if let validURL = URL(string: endPoint) {
            
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: validURL, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil {
                    print("Session error: \(error)")
                }
                
                if let validData = data {
                    callback(validData)
                }
                
                
            }).resume()
        }
    }
}
