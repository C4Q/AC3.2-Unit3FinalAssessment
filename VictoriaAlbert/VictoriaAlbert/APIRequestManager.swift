//
//  APIRequestManager.swift
//  VictoriaAlbert
//
//  Created by Thinley Dorjee on 11/10/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class APIRequestManager{
    static let manager = APIRequestManager()
    private init(){}
    
    func getData(endPoint: String, completion: @escaping ((Data?)->Void)){
        guard let myURL = URL(string: endPoint) else {return}
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil{
                print("Error encounter \(error)")
            }
            guard let validData = data else {return }
            completion(validData)
            }.resume()
    }
    
    
    func downloadImage(urlString: String, callback: @escaping (Data) -> () ) {
        guard let imageURL = URL(string: urlString) else { return }
        let session = URLSession.shared
        session.dataTask(with: imageURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error encountered!: \(error!)")
            }
            guard let imageData = data else { return }
            callback(imageData)
            
            }.resume()
    }
}

