//
//  Pic.swift
//  VictoriaAlbert
//
//  Created by Marty Avedon on 11/10/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import Foundation

class Pic {
    let imageID: String
    let startOfURL = "http://media.vam.ac.uk/media/thira/collection_images/"
    //second part of url is '[first 6 elements of imageID]/'
    let secondPart: String
    let suffixForThumb = "_jpg_o.jpg"
    let suffixForBig = ".jpg"
    let bigPic: String
    let thumbPic: String
    
    // total url looks like startOfUrl + secondPart + imageID + suffix
    // sample for detail: http://media.vam.ac.uk/media/thira/collection_images/2006AM/2006AM6763.jpg
    
    init(_ imageID:String) {
        self.imageID = imageID
        var secondPart = ""
        for char in imageID.characters {
            secondPart += String(char)
        }
        self.secondPart = secondPart
        self.bigPic = startOfURL + secondPart + imageID + suffixForBig
        self.thumbPic = startOfURL + secondPart + imageID + suffixForThumb
    }
    
    class func picParse(_ dict: [String : Any]) -> Pic? {
        guard let objectData = dict["pic"] as? [String: Any],
            let id = objectData["id"] as? String else { return nil }
        return Pic(id)
    }
}
