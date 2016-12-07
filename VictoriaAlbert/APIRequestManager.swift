//
//  APIRequestManager.swift
//  VictoriaAlbert
//
//  Created by Ana Ma on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class APIRequestManager{
    static let manager: APIRequestManager = APIRequestManager()
    
    private init (){}
    
    func getData (endpoint: String, complete: @escaping ((Data?) -> Void) ) {
        guard let url = URL(string: endpoint) else {return}
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print(error)
            }
            
            if data != nil {
                complete(data)
            }
            }.resume()
    }
}
