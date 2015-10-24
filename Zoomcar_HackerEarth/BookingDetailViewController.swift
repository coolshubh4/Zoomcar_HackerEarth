//
//  BookingDetailViewController.swift
//  Zoomcar_HackerEarth
//
//  Created by Shubham Tripathi on 19/09/15.
//  Copyright © 2015 coolshubh4. All rights reserved.
//

import UIKit
import MapKit

class BookingDetailViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var hourlyRate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var seater: UILabel!
    @IBOutlet weak var carAC: UILabel!
    
    
    var carToBeBooked: Car!
    
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Booking Details"
        mapView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        carName.text = carToBeBooked.name
        hourlyRate.text = "\(carToBeBooked.hourlyRate!) per hr"
        rating.text = "Rating: \(carToBeBooked.rating!)"
        seater.text = "Seater: \(carToBeBooked.seater!)"
        if carToBeBooked.ac == "1" {
            carAC.text = "AC: yes"
        } else {
            carAC.text = "AC: no"
        }
        
        if let loc = carToBeBooked.location as? [String : AnyObject] {
            let lat = loc["latitude"]!
            let lon = loc["longitude"]!
            latitude = Double(lat as! String)!
            longitude = Double(lon as! String)!
            carLocation()
        }
    }
    
    func carLocation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func shareCarDetails(sender: AnyObject) {
        
        let controller = UIActivityViewController(activityItems: [carToBeBooked.name!], applicationActivities: nil)
        
        presentViewController(controller, animated: true, completion: nil)
        
        
//        let controller = UIActivityViewController(activityItems: [carName.text, hourlyRate.text], applicationActivities: nil)
//        
//        controller.completionWithItemsHandler = { activity, success, items, error in
//            
//            print("Activity: \(activity) Success: \(success) Items: \(items) Error: \(error)")
//            controller.dismissViewControllerAnimated(true, completion: nil)
//        }
//        presentViewController(controller, animated: true, completion: nil)
    }

}