//
//  APIHelper.swift
//  VictoriaAlbert
//
//  Created by Marty Avedon on 11/10/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import Foundation

// this is taken directly, with no alternation, from Tom's code for the last assessment: https://github.com/seymotom/AC3.2-Unit3MidunitAssessment/blob/master/AC3.2-Unit3MidunitAssessment/AC3.2-Unit3MidunitAssessment/APIHelper.swift

class APIHelper {
    
    static let manager = APIHelper()
    private init() {}
    
    func getData(endPoint: String, callback: @escaping (Data?) -> () ) {
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Encountered error durring session:   \(error)")
            }
            guard let validData = data else { return }
            callback(validData)
            }.resume()
    }
}
