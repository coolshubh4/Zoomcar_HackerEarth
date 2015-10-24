//
//  ZHEClient.swift
//  Zoomcar_HackerEarth
//
//  Created by Shubham Tripathi on 19/09/15.
//  Copyright © 2015 coolshubh4. All rights reserved.
//

import Foundation

class ZHEClient: NSObject {
    
    var session: NSURLSession
    var carData = [Car]()
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    func getCarsDetails(completionHandler: (success: Bool, errorString: String?) -> Void) {
        print("inside getCarsDetails")
        let request = NSURLRequest(URL: NSURL(string: "https://zoomcar.0x10.info/api/zoomcar?type=json&query=list_cars")!)
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                completionHandler(success: false, errorString: "Not able to request, error - \(error)")
            } else {
                ZHEClient.parseJSONWithCompletionHandler(data!) { result, error in
                    if error != nil {
                        completionHandler(success: false, errorString: "Could not parse data, error- \(error)")
                    } else {
                        if let dataResult = result as? [String : AnyObject] {
                            if let cars = dataResult["cars"] as? [[String : AnyObject]] {
                                ZHEClient.sharedInstance().carData.removeAll(keepCapacity: true)
                                for car in cars {
                                    print("car - \(car)")
                                    let car = Car(carDict: car)
                                    ZHEClient.sharedInstance().carData.append(car)
                                }
                                //print(cars.count)
                                //print(cars)
                                completionHandler(success: true, errorString: nil)
                            }
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    /* Helper: Given raw JSON, return a usable Foundation object */
    class func parseJSONWithCompletionHandler(data: NSData, completionHandler: (result: AnyObject!, error: NSError?) -> Void) {
        //print("inside parseJSONWithCompletionHandler")
        var parsingError: NSError? = nil
        let parsedResult: NSDictionary?
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
        } catch let error as NSError {
            parsingError = error
            parsedResult = nil
        }
        //print("parseJSONWithCompletionHandler parsedResult - \(parsedResult) parsingError - \(parsingError)")
        if let error = parsingError {
            completionHandler(result: nil, error: error)
        } else {
            completionHandler(result: parsedResult!, error: nil)
        }
    }
    
    class func sharedInstance() -> ZHEClient {
        
        struct Singleton {
            static var sharedInstance = ZHEClient()
        }
        return Singleton.sharedInstance
    }
}