//
//  Museum.swift
//  VictoriaAlbert
//
//  Created by Harichandan Singh on 11/10/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import Foundation

enum ParsingErrors: Error {
    case recordsArrayError, fieldsDictError, objectError, dateTextError, placeError, titleError, primaryImageIDError, artistError, locationError, museumNumberError, yearError
}
class Museum {
    //MARK: - Properties
    let object: String
    let dateText: String
    let place: String
    let title: String
    let primaryImageID: String
    let artist: String
    let location: String
    let museumNumber: String
    let year: Int
    
    //MARK: - Initializers
    init(object: String, dateText: String, place: String, title: String, primaryImageID: String, artist: String, location: String, museumNumber: String, year: Int) {
        self.object = object
        self.dateText = dateText
        self.place = place
        self.title = title
        self.primaryImageID = primaryImageID
        self.artist = artist
        self.location = location
        self.museumNumber = museumNumber
        self.year = year
    }
    
    //MARK: - Methods
    static func turnDataIntoMuseumArray(data: Data) -> [Museum]? {
        do {
            //get JSON Data
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            
            //Parsing data
            guard let museumDict = jsonData as? [String: Any] else {
                print("There was an error casting the JSON data!")
                return nil
            }
            print("Data successfully casted into museumDict.")
            
            guard let recordsArray = museumDict["records"] as? [[String: Any]] else {
                throw ParsingErrors.recordsArrayError
            }
            print("Data successfully casted into recordsArray.")
            
            var allMuseums: [Museum] = []
            
            //loop through array to find property values
            for dict in recordsArray {
                guard let fieldsDict = dict["fields"] as? [String: Any] else {
                    throw ParsingErrors.fieldsDictError
                }
                
                guard let object = fieldsDict["object"] as? String else {
                    throw ParsingErrors.objectError
                }
                
                guard let dateText = fieldsDict["date_text"] as? String else {
                    throw ParsingErrors.dateTextError
                }
                
                guard let place = fieldsDict["place"] as? String else {
                    throw ParsingErrors.placeError
                }
                
                let title = fieldsDict["title"] as? String
                
                guard let primaryImageID = fieldsDict["primary_image_id"] as? String else {
                    throw ParsingErrors.primaryImageIDError
                }
                
                guard let artist = fieldsDict["artist"] as? String else {
                    throw ParsingErrors.artistError
                }
                
                guard let location = fieldsDict["location"] as? String else {
                    throw ParsingErrors.locationError
                }
                
                guard let museumNumber = fieldsDict["museum_number"] as? String else {
                    throw ParsingErrors.museumNumberError
                }
                
                guard let year = fieldsDict["year_start"] as? Int else {
                    throw ParsingErrors.yearError
                }
                
                let museum: Museum = Museum(object: object, dateText: dateText, place: place, title: title ?? "", primaryImageID: primaryImageID, artist: artist, location: location, museumNumber: museumNumber, year: year)
                allMuseums.append(museum)
            }
            return allMuseums
            
        }
        catch ParsingErrors.recordsArrayError {
            print("There was an error finding the 'records' key.")
        }
        catch ParsingErrors.fieldsDictError {
            print("There was an error finding the 'fields' key.")
        }
        catch ParsingErrors.objectError {
            print("There was an error finding the 'object' key.")
        }
        catch ParsingErrors.dateTextError {
            print("There was an error finding the 'date_text' key.")
        }
        catch ParsingErrors.placeError {
            print("There was an error finding the 'place' key.")
        }
        catch ParsingErrors.titleError {
            print("There was an error finding the 'title' key.")
        }
        catch ParsingErrors.primaryImageIDError {
            print("There was an error finding the 'primary_image_id' key.")
        }
        catch ParsingErrors.artistError {
            print("There was an error finding the 'artist' key.")
        }
        catch ParsingErrors.locationError {
            print("There was an error finding 'location' key.")
        }
        catch ParsingErrors.museumNumberError {
            print("There was an error finding the 'museum_number' key.")
        }
        catch ParsingErrors.yearError {
            print("There was an error finding the 'year_start' key.")
        }
        catch {
            print("There was an unexpected error!")
        }
        return nil
    }
}
