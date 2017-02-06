//
//  ApiManager.swift
//  VictoriaAlbert
//
//  Created by Margaret Ikeda on 11/10/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import Foundation
class ApiManager {
    static let manager: ApiManager = ApiManager()
    private init () {}
    
    func getVictoriaObjectData(endpoint: String, callback: @escaping (Data?) -> Void) {
        
        guard let myUrl = URL(string: endpoint) else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: myUrl) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error encountering \(error)")
            }
            guard let validData = data else { return }
            callback(validData)
            } .resume()
    }
}
