//
//  APIRequestManager.swift
//  VictoriaAlbert
//
//  Created by Erica Y Stevens on 11/10/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import Foundation

//This class retrieves URL data and parses JSON data into objects
class APIRequestManager {
    static let manager: APIRequestManager = APIRequestManager()
    private init() {}
    
    //This method makes an APIRequest & instantiates Museum Objects
    func getDataFrom(apiEndpoint: String, callback: @escaping ([MuseumObject]?) -> Void) {
        
        //Convert String to URL
        if let url = URL(string: apiEndpoint) {
            
            //URLSession
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            //Data Task With URL
            session.dataTask(with: url) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
                
                //Immediately check for errors
                if error != nil {
                    print("Error encountered in Data Task: \(error)")
                }
                
                //Check for valid data
                if let validData = data {
                    if let museumObjects: [MuseumObject] = APIRequestManager.manager.getMuseumObjects(from: validData) {
                        print("Data Loading Successful!")
                        print(museumObjects)
                        callback(museumObjects)
                    }
                }
                
            }.resume()
            
        } else {
            print("String was not able to be converted into a URL")
        }
    }
    
    //This method creates an array of MuseumObjects from the JSON data retrieved from the URLRequest
    func getMuseumObjects(from jsonData: Data) -> [MuseumObject]? {
        do {
            let musuemObjectData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            //Cast from Any and index into JSON data 
            guard let museumObjectJSONData: [String:AnyObject] = musuemObjectData as? [String:AnyObject], let museumObjectArrayOfDicts: [[String:AnyObject]] = museumObjectJSONData["records"] as? [[String:AnyObject]] else {
                print("Could not index into JSON data")
                return nil
            }
            
            var musuemObjects: [MuseumObject] = []
            //Now that we are in the JSON dict, parses the necessary info
            museumObjectArrayOfDicts.forEach({ (museumDict: [String:AnyObject]) in
                guard let fields: [String:AnyObject] = museumDict["fields"] as? [String:AnyObject]else {
                    print("Incorrectly accesses Fields Dictionary")
                    return
                }
                
                //We made it to the important part of the data, now we can just pull the values out
                guard let objectName: String = fields["object"] as? String, let place: String = fields["place"] as? String, let location: String = fields["location"] as? String, let dateText: String = fields["date_text"] as? String, let imageID: String = fields["primary_image_id"] as? String, let title: String = fields["title"] as? String, let artist: String = fields["artist"] as? String, let yearStart: Int = fields["year_start"] as? Int else {
                    print("Cannot load values for initializer")
                    return
                }
                
                //Instantiate object
                musuemObjects.append(MuseumObject(objectName: objectName, place: place, location: location, dateText: dateText, imageID: imageID, title: title, artist: artist, yearStart: yearStart))
            })
            
            return musuemObjects
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        return nil
    }

    //This method is used to build the URL for the thumbnail images
    func getThumbnailImageURLfrom(imageID: String) -> URL? {
        let serverLocation = "http://media.vam.ac.uk/media/thira/collection_images/"
        let directory = "\(String(imageID.characters.prefix(6)))/"
        let suffix = "_jpg_o.jpg"
        let urlString = serverLocation + directory + imageID + suffix
        
        if let url = URL(string: urlString) {
            return url
        } else {
            return nil
        }
    }
    
    //This method is used to build the URL string for the full-sized images
    func getFullSizedImageURLFrom(imageID: String) -> String {
        let serverLocation = "http://media.vam.ac.uk/media/thira/collection_images/"
        let directory = "\(String(imageID.characters.prefix(6)))/"
        let suffix = ".jpg"
        let urlString = serverLocation + directory + imageID + suffix
        
        return urlString
    }

    
}
