//
//  Car.swift
//  Zoomcar_HackerEarth
//
//  Created by Shubham Tripathi on 19/09/15.
//  Copyright © 2015 coolshubh4. All rights reserved.
//

import MapKit

struct Car {
    
    var type: String? = nil
    var name: String? = nil
    var hourlyRate: String? = nil
    var seater: String? = nil
    var rating: String? = nil
    var ac: String? = nil
    var imageURL: String? = nil
    var location: NSDictionary?
//    var latitude: CLLocationDegrees? = nil
//    var longitude: CLLocationDegrees? = nil
    
    init(carDict: [String: AnyObject]) {
        
        self.type = carDict["type"] as? String
        self.name = carDict["name"] as? String
        self.hourlyRate = carDict["hourly_rate"] as? String
        self.seater = carDict["seater"] as? String
        self.rating = carDict["rating"] as? String
        self.ac = carDict["ac"] as? String
        self.imageURL = carDict["image"] as? String
        
        self.location = carDict["location"] as? NSDictionary
    }
    
//    var latitude: CLLocationDegrees {
//        var latitude: Double
//        if let loc = self.location as? [String : AnyObject] {
//            let lat = loc["latitude"]!
//            //return lat as? Double
//            latitude = lat as! Double
//        }
//        return latitude
//    }
//    
//    var longitude: CLLocationDegrees? {
//        if let loc = self.location as? [String : AnyObject] {
//            let lon = loc["longitude"]!
//            return lon as? Double
//        }
//        return nil
//    }
}