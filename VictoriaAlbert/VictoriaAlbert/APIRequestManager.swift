//
//  APIRequestManager.swift
//  VictoriaAlbert
//
//  Created by Harichandan Singh on 11/10/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import Foundation

class APIRequestManager {
    //MARK: - Properties
    static let manager = APIRequestManager()
    
    
    //MARK: - Initializers
    private init() {}
    
    
    //MARK: - Methods
    func getData(apiEndpoint: String, callback: @escaping (Data) -> Void) {
        
        //create URL from apiEndpoint
        guard let url = URL(string: apiEndpoint) else { return }
        
        //create URL session
        let session = URLSession.init(configuration: .default)
        
        //create task
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Encountered the following error: \(error)")
            }
            
            //create JSON Data from optional data
            guard let jsonData = data else { return }
            
            //provide JSON data to callback parameter
            callback(jsonData)
            
        }.resume()
    }
}
