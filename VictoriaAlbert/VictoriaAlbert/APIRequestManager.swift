//
//  APIRequestManager.swift
//  VictoriaAlbert
//
//  Created by Jermaine Kelly on 11/10/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation


class APIRequestManager{
    
    static let manager = APIRequestManager()
    private init (){}
    
    
    func getData(from endpoint:String, completion: @escaping ((Data?)->Void)){
        
        guard let url = URL(string: endpoint) else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil{
                print("=====> \n \(error.debugDescription) \n =====<")
            }
            
            if let validData = data{
                completion(validData)
            }
            }.resume()
    }
    
}
