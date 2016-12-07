//
//  APIRequestManager.swift
//  VictoriaAlbert
//
//  Created by Annie Tung on 11/10/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

class APIRequestManager {
    
    static let manager: APIRequestManager = APIRequestManager()
    private init() {}
    
    func getData(apiEndPoint: String, callback: @escaping ((Data?)) -> Void) {
        
        guard let myURL = URL(string: apiEndPoint) else { return }
        
        let session = URLSession.init(configuration: .default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("Error encountered at \(error)")
            }
            guard let validData = data else { return }
            callback(validData)
        }
        .resume()
    }
}
