//
//  APIHelper.swift
//  VictoriaAlbert
//
//  Created by Marty Avedon on 11/10/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import Foundation

//this is modified from my instaCats project: https://github.com/jerjunkel/AC3.2-NSURLSession/blob/master/InstaDogFactory.swift

func APIHelper(endpoint: String, callback: @escaping ([BricABrac]?) -> ()) {
    if let validEndpoint: URL = URL(string: endpoint) {
        // 1. URLSession/Configuration
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // 2. dataTaskWithURL
        session.dataTask(with: validEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
            // 3. check for errors right away
            if error != nil {
                print("Error encountered!: \(error!)")
            }
            // 4. printing out the data
            if let validData: Data = data {
                // print(validData)
                // 5. reuse our code to make some cats from Data
                let allTheBricABrac: [BricABrac]? = BricABrac.makeBricArr(from: validData)
                callback(allTheBricABrac) //callback closure
            }
            }.resume()
    }
}
