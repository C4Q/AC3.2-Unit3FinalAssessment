//
//  APIRequestManager.swift
//  VictoriaAlbert
//
//  Created by Cris on 11/10/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import Foundation

class APIRequestManager {
    static let manager = APIRequestManager()
    private init() {}
    
    func getData(endPoint: String, callback: @escaping ((Data?) -> Void)) {
        guard let APIURL = URL(string: endPoint) else {return}
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: APIURL) { (data: Data?, reponse: URLResponse?, error: Error?) in
            if error != nil {
                print("ERROR DURRING SESSION: \(error)")
            }
            guard let validData = data else {return}
            callback(validData)
            
        }.resume()
        
        
    }
    
    
    
}
