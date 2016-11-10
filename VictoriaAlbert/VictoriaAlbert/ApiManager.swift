//
//  ApiManager.swift
//  VictoriaAlbert
//
//  Created by Amber Spadafora on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class ApiManager {
    static let manager = ApiManager()
    private init() {}
    
    func getData(endPointUrl: URL, callback: @escaping ((Data?) -> Void)) {
        let currentUrlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        currentUrlSession.dataTask(with: endPointUrl) {(data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("There was an error during session: \(error)")
            }
            
            if data != nil {
                callback(data)
                print("Api Manager was successful in retrieving data from the provided URL")
            }
        }
        .resume()
    }
    
}
